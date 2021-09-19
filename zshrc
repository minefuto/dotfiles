### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

zinit light chrissicool/zsh-256color
BASE16_SHELL="$HOME/.zinit/plugins/chriskempson--base16-shell/"
zinit ice atload'eval "$("$BASE16_SHELL/profile_helper.sh")"'
zinit light chriskempson/base16-shell

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

bindkey -e

autoload -Uz colors
colors
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=2

setopt no_flow_control
setopt share_history

alias ls="ls -G"
alias ll="ls -l"
alias la="ls -al"
alias grep="grep --color=always"
alias vi="vim"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

function _ssh {
  compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
}

function qcd() {
  qwertycd
  cd "`cat $HOME/.qwertycd/cache_dir`"
}

function transparent-pipe() {
  BUFFER="$(tp -c "${BUFFER}")"
  CURSOR=$#BUFFER
}
zle -N transparent-pipe
bindkey "^|" transparent-pipe
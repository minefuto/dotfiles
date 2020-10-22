set -Ux XDG_CONFIG_HOME ~/.config
set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux GOPATH $HOME/go
set -Ux GOBIN $GOPATH/bin
set -U fish_user_paths $GOBIN $PYENV_ROOT/bin $HOME/.nimble/bin /usr/local/bin $fish_user_paths

# Fisher
if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

# Base16 Shell
if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

set -Ux EDITOR vim
set -U pure_symbol_prompt ">"

set -U fish_color_normal normal
set -U fish_color_command ffffff
set -U fish_color_quote a8a8a8
set -U fish_color_redirection 808080
set -U fish_color_end 949494
set -U fish_color_error 585858
set -U fish_color_param d7d7d7
set -U fish_color_comment bcbcbc
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 777777
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

alias vi='vim'

# qwertycd 
function qcd
  qwertycd
  cd (cat $HOME/.cache/qwertycd/cache_dir)
end

function transparent-pipeline
  commandline | read -l buffer
  commandline (tp -c "$buffer")
end

function fish_user_key_bindings
  bind \ct transparent-pipeline
end


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

set -U fish_user_paths (echo $fish_user_paths | tr ' ' '\n' | sort -u)

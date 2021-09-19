#!/usr/bin/env bash

set -ue

title() {
  echo ""
  echo "============================="
  echo $1
  echo "============================="
}

task() {
  echo ""
  echo "+ $1"
}

has() {
  type "$1" > /dev/null 2>&1
}

setup_homebrew() {
  title "Setup HomeBrew"
  task "Installing homebrew."
  if [ has "brew" ]; then
    "Homebrew already installed."
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  task "Installing packages from Brewfile."
  brew bundle --file "~/dotfiles/brew/Brewfile"
}

setup_dotfiles() {
  title "Setup Dotfiles"
  task "Downloading dotfiles."
  if [ -e "~/dotfiles" ]; then
    echo "Dotfiles already exists."
    exit 1
  fi
  git clone https://github.com/minefuto/dotfiles.git ~/dotfiles

  task "Creating symlink(~/.config/nvim)."
  ln -s ~/dotfiles/nvim ~/.config/nvim

  task "Creating symlink(.tmux.conf)."
  ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

  task "Creating symlink(.zshenv)."
  ln -s ~/dotfiles/zsh/zshenv ~/.zshenv

  task "Creating symlink(.zshrc)."
  ln -s ~/dotfiles/zsh/zshrc ~/.zshrc

  task "Creating symlink(.gitconfig)."
  ln -s ~/dotfiles/git/gitconfig ~/.gitconfig

  task "Creating symlink(.gitignore_global)."
  ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global
}

setup_nim() {
  title "Setup Nim Enviromnets"
  task "Installing nim."
  if [ has "nim" ]; then
    echo "Nim already installed."
    exit 1
  fi
  curl https://nim-lang.org/choosenim/init.sh -sSf | sh

  task "Installing nimlsp."
  export PATH=~/.nimble/bin:$PATH
  nimble install -y nimlsp 
}

setup_go() {
  title "Setup Go Enviromnets"
  task "Installing goimports."
  go get golang.org/x/tools/cmd/goimports
}

setup_nvim() {
  title "Setup NeoVim"
  task "Downloading vim-plug."
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

setup_zsh() {
  title "Setup Zsh"
  task "Creating ~/.zinit."
  mkdir ~/.zinit

  task "Downloading zinit."
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin

  task "Changing permission(/usr/local/share/zsh)."
  chmod 775 /usr/local/share/zsh

  task "Changing permission(/usr/local/share/zsh/site-functions)."
  chmod 775 /usr/local/share/zsh/site-functions
}

setup_mac() {
  title "Setup MacOS Environment"
  scutil --set ComputerName "macOS"
  scutil --set HostName "minefuto"
  scutil --set LocalHostName "minefuto"
  sudo spctl --master-disable
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write KeyRepeat -int 2
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock tilesize -int 35
  defaults write com.apple.dock magnification -bool false
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock orientation -string left
  defaults write com.apple.dock mineffect -string scale
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"
  defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'

  TERM_PROFILE='OneHalfLight_minefuto';
  TERM_PATH='./terminal/';
  CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
  if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
      open "$TERM_PATH$TERM_PROFILE.terminal"
      defaults write com.apple.Terminal "Default Window Settings" -string "$TERM_PROFILE"
      defaults write com.apple.Terminal "Startup Window Settings" -string "$TERM_PROFILE"
  fi
  defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"
}

setup_homebrew
setup_mac

setup_dotfiles
setup_nim
setup_go
setup_nvim
setup_zsh

title "Complate"

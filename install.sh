#!/usr/bin/env bash
set -ue

# setup homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update && brew upgrade

# setup desktop app
brew install --cask appcleaner
brew install --cask docker
brew install --cask google-chrome
brew install --cask google-japanese-ime
brew install --cask zoomus
brew install --cask typora
brew install --cask karabiner-elements
brew install --cask virtualbox
brew install --cask microsoft-teams
brew install --cask keycastr
brew install --cask licecap
brew install --cask alacritty
brew install --cask wireshark

# setup python3
brew install python3
brew install pyenv
brew install pipenv

# setup nim
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
nimble install nimlsp

# setup go
brew install go
go get golang.org/x/tools/cmd/goimports

# setup font
git clone https://github.com/powerline/fonts.git
./fonts/install.sh

# setup vim
brew install vim
brew install node
ln -s $HOME/dotfiles/vim $HOME/.vim
curl -flo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# setup tmux
brew install tmux
brew install reattach-to-user-namespace
pip3 install powerline-status
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.config/tmux/tmux.conf

# setup zsh
brew install zsh
mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc

# setup git
brew install git
ln -s $HOME/dotfiles/git/config $HOME/.config/git/config

# alacritty
ln -s $HOME/dotfiles/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# karaviner-elements
ln -s $HOME/dotfiles/karabiner/citrix-toggle.json $HOME/.config/karabiner/assets/complex_modifications/citrix-toggle.json

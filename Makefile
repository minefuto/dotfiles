DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard ??*)

DOTCONFIGS := git
EXCLUSIONS := README.md Makefile $(DOTCONFIGS)
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

BREW_PKGS  := git tmux vim zsh go python@3.9 pyenv poetry node reattach-to-user-namespace
BREW_PKGS  += alacritty appcleaner docker google-chrome kap wireshark

#DNF_PKGS   := git tmux vim zsh node

OS         := Mac
PKG_PATH   := /usr/local/bin

#ifeq ($i(shell uname),Linux)
#	OS      := CentOS
#	PKG_PATH := /bin
#endif

.PHONY: list
list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

.PHONY: package
package:
ifeq ($(OS), Mac)
ifeq ($(shell command -v brew 2> /dev/null),)
	@/bin/bash -c "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`"
endif
	@$(PKG_PATH)/brew install $(BREW_PKGS)
#else
#	@$(PKG_PATH)/dnf install -y $(DNF_PKGS)
endif

.PHONY: font
font:
ifeq ($(OS), Mac)
ifeq ($(shell ls $${HOME}/Library/Fonts 2> /dev/null | grep Cica-Regular.ttf),)
	@curl -L https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip > $${HOME}/Downloads/Cica.zip
	@unzip $${HOME}/Downloads/Cica.zip -d $${HOME}/Downloads/
	@mv $${HOME}/Downloads/*.ttf $${HOME}/Library/Fonts/
	@rm $${HOME}/Downloads/Cica.zip
	@rm $${HOME}/Downloads/LICENSE.txt
	@rm $${HOME}/Downloads/COPYRIGHT.txt
endif
endif

.PHONY: go
go:
ifeq ($(shell command -v go 2> /dev/null),)
	@$(PKG_PATH)/go get golang.org/x/tools/cmd/goimports
endif

.PHONY: vim
vim:
ifeq ($(shell ls $${HOME}/.vim/autoload 2> /dev/null | grep plug.vim),)
	@curl -fLo $${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

.PHONY: symlink
symlink:
ifeq ($(shell ls -a $${HOME}/ 2> /dev/null | grep .config),)
	@mkdir $(HOME)/.config
endif
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $${HOME}/.$(val);)
	@$(foreach val, $(DOTCONFIGS), ln -sfnv $(abspath $(val)) $${HOME}/.config/$(val);)

.PHONY: install
install: package go symlink vim font

.PHONY: update
update:
	@git pull
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $${HOME}/.$(val);)

.PHONY: clean
clean:
	@$(foreach val, $(DOTFILES), rm -vrf $${HOME}/.$(val);)
	@rm -rf $(DOTPATH)

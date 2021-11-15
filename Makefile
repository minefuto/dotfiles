DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard ??*)

DOTCONFIGS := git
EXCLUSIONS := README.md Makefile $(DOTCONFIGS)
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

BREW_PKGS  := git tmux vim zsh go python@3.9 pyenv poetry node reattach-to-user-namespace
BREW_PKGS  += appcleaner docker google-chrome google-japanese-ime kap typora wireshark

DNF_PKGS   := git tmux vim zsh node

OS         := Mac
PKG_PATH   := /usr/local/bin

ifeq ($i(shell uname),Linux)
	OS      := CentOS
	PKG_PATH := /bin
endif

.PHONY: list
list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

.PHONY: package
package:
ifeq (${OS}, Mac)
ifeq ($(shell command -v brew 2> /dev/null),)
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
endif
	@${PKG_PATH}/brew install $(BREW_PKGS)
else
	@${PKG_PATH}/dnf install -y $(DNF_PKGS)
endif

.PHONY: go
go:
ifeq ($(shell command -v go 2> /dev/null),)
	@${PKG_PATH}/go get golang.org/x/tools/cmd/goimports
endif

.PHONY: nim
nim:
ifeq ($(shell command -v nim 2> /dev/null),)
	@curl https://nim-lang.org/choosenim/init.sh -sSf | sh
	@$${HOME}/.nimble/bin/nimble install -y nimlsp
endif

.PHONY: vim
vim:
ifeq ($(shell ls $${HOME}/.vim/autoload 2> /dev/null | grep plug.vim),)
	@curl -fLo $${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

.PHONY: symlink
symlink:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTCONFIGS), ln -sfnv $(abspath $(val)) $(HOME)/.config/$(val);)

.PHONY: install
install: package go nim vim symlink

.PHONY: update
update:
	@git pull
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

.PHONY: clean
clean:
	@$(foreach val, $(DOTFILES), rm -vrf $(HOME)/.$(val);)
	@rm -rf $(DOTPATH)

HOST ?= macbook
FLAKE ?= $(HOME)/dotfiles\#$(HOST)

.PHONY: install switch check flake-check mise-install pre-commit

install: switch mise-install

switch:
	sudo darwin-rebuild switch --flake "$(FLAKE)"

check: flake-check
	darwin-rebuild check --flake "$(FLAKE)"

flake-check:
	nix flake check

mise-install:
	mise install

pre-commit:
	pre-commit run --all-files

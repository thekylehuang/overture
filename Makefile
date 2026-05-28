.PHONY: switch update gc check

switch:
	sudo darwin-rebuild switch --flake .

update:
	nix flake update && sudo darwin-rebuild switch --flake .

gc:
	sudo nix-collect-garbage -d

check:
	nix flake check

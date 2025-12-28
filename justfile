_default: 
    @just --list

rebuild:
    home-manager switch -b backup -f .devcontainer/home.nix

export USER := shell("whoami")
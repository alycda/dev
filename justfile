_default: 
    @just --list

rebuild:
    home-manager switch -b backup -f .devcontainer/home.nix

export USER := shell("whoami")

cheats:
    cheat -l

present:
    presenterm slides.md

# re-run with CMD+SHIFT+P > Tasks: Run Task > Present with Speaker Notes
# present-with-speaker-notes:
#     presenterm --publish-speaker-notes slides.md
#     presenterm --listen-speaker-notes slides.md
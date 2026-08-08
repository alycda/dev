{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [ jujutsu just cheat asciinema presenterm tmux mdbook ripgrep ];
}
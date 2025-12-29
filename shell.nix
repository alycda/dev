{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [ just cheat ];
  
  # shellHook = ''
  #   jj config set --user user.name "$(git config --get user.name)" 
  #   jj config set --user user.email "$(git config --get user.email)"
  # '';
}
{ pkgs, ... }:
{
  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Core tools available everywhere
  home.packages = with pkgs; [
    helix
    ripgrep
  ];

  # direnv with nix-direnv for fast flake loading
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "24.05";
  home.username = "root";  # Since you're running as root in the container
  home.homeDirectory = "/root";
}
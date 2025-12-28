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

  # Enable bash so home-manager can add direnv hook
  programs.bash = {
    enable = true;

    # initExtra is added to .bashrc for interactive shells
    initExtra = ''
      # Source session vars for non-login shells
      if [[ ! -v __HM_SESS_VARS_SOURCED ]]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  };

  # xdg.configFile."cheat/conf.yml".text = ''
  #   # ... cheat config ...
  # '';

  # Set globally
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "code";
    CHEAT_CONFIG_PATH = "/workspaces/dev/.devcontainer/cheat/conf.yml";
  };

  home.stateVersion = "24.05";
  home.username = "root";  # Since you're running as root in the container
  home.homeDirectory = "/root";
}
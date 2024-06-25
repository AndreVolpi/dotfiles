{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./nixvim.nix
  ];

  home.username = "kurumas";
  home.homeDirectory = "/home/kurumas";

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gnumake
    gnupg
    binutils
    moreutils
    coreutils
    less
    ripgrep
    fd
    jq
    wget
    bat
    htop
    openssh
  ];

  home.file = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;

  programs.bash.enable = true;
}

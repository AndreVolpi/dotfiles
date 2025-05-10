{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./starship.nix
    ./tmux.nix
  ];

  home.username = "kurumas";
  home.homeDirectory = "/home/kurumas";

  home.stateVersion = "24.05";

  news.display = "show";

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
    cascadia-code
    gping
    docker
    docker-compose
  ];

  home.file = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;

    initExtra = "tmux a";
  };

  fonts.fontconfig.enable = true;
}

{ pkgs, ... }:
{
  imports = [
    ./aider.nix
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  home.username = "kurumas";
  home.homeDirectory = "/home/kurumas";

  news.display = "show";

  home.file = { };
  home.sessionVariables = { };

  nixpkgs.config.allowUnfree = true;
  nix.gc.automatic = true;

  home.packages = with pkgs; [
    bat
    binutils
    cascadia-code
    comma
    coreutils
    docker
    docker-compose
    fd
    gnumake
    gnupg
    gping
    htop
    jq
    less
    moreutils
    openssh
    ripgrep
    wget
  ];

  programs.bash = {
    enable = true;

    initExtra = "tmux a";
  };

  fonts.fontconfig.enable = true;
}

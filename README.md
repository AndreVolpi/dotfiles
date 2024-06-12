# Dotfiles

## Setup

These dotfiles are managed with [Nix](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager).

- Installing Nix (example for linux, check Nix documentation for other OS)
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

- Installing Home Manager
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

- Installing these Dotfiles
```sh
git clone https://github.com/AndreVolpi/dotfiles.git ~/dotfiles
ln -fs ~/dotfiles/home.nix ~/.config/home-manager/home.nix
```

- Activate the environment
```sh
home-manager switch
```

## Details

This is the dotfiles setup which I use for my Ubuntu.

To use it with other systems, code changes are likely to be needed. Feel free to send a Pull Request.

Below is the list of installed and configured packages:

- [Nix](https://nix.dev)
- [direnv](https://nix.dev/guides/recipes/direnv.html)
- [Starship](https://starship.rs/)
- [Fish](https://fishshell.com)
- [Tmux](https://github.com/tmux/tmux)
- [git](https://git-scm.com/)
  - [gita](https://github.com/nosarthur/gita)
- [eza](https://github.com/eza-community/eza)
- [FZF](https://github.com/junegunn/fzf)
- [Forgit](https://github.com/wfxr/forgit)
- [NeoVim](http://neovim.io/)
  - Along with many plugins.

# Dotfiles

## Setup

- Install these dotfiles with:
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply AndreVolpi$
```

- It will also install the Cascadia Code Font, enable it where desired.

- Install ASDF plugins for the desired languages:
```sh
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python https://github.com/danhper/asdf-python.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

asdf install
```

## Details

This is the dotfiles setup which I use for my Ubuntu and MacOS.
[Chezmoi](https://www.chezmoi.io/) is used to manage the dotfiles themselves as well as package installation.
[ASDF](https://asdf-vm.com) is used to manage languages.

To use it with other systems, code changes are likely to be needed. Feel free to send a Pull Request.

Below is the list of installed and configured packages:

- [Starship](https://starship.rs/)
- [Fish](https://fishshell.com)
- [Tmux](https://github.com/tmux/tmux)
- [git](https://git-scm.com/)
- [eza](https://github.com/eza-community/eza)
- [FZF](https://github.com/junegunn/fzf)
- [Forgit](https://github.com/wfxr/forgit)
- [Docker](http://docker.com)
- [NeoVim](http://neovim.io/)
  - Along with many plugins.

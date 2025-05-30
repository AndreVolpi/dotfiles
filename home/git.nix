{ pkgs, ... }:
{
  home.packages = with pkgs; [ gita ];

  programs.git = {
    enable = true;
    userEmail = "devolpi@gmail.com";
    userName = "André Volpi";

    aliases = {
      st = "status -sb";
      ci = "commit -S -v";
      mi = "merge -S";
      co = "checkout";
      br = "branch -vv";
      ps = "push -v";
      lg = "log --oneline --graph";
    };

    extraConfig = {
      init.defaultBranch = "main";
      pull = { rebase = true; };
      commit = { verbose = true; };
      color = {
        ui = true;
        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };
        diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          new = "green bold";
        };
      };
      push = {
        default = "simple";
        autoSetupRemote = "true";
      };
      apply = { whitespace = "fix"; };
      core = { editor = "nvim"; };
      rerere = {
        enabled = true;
        autoUpdate = true;
      };
    };

    ignores = [
      # direnv caches
      ".direnv/"
      ".envrc"
      "shell.nix"
      ".nvim.lua"
    ];

    signing = {
      signByDefault = true;
      key = null;
    };

    lfs = { enable = true; };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-tty;
  };
}

{ pkgs, ...}:
{
  home.packages = with pkgs; [ gita ];

  programs.git = {
    enable = true;
    userEmail = "devolpi@gmail.com";
    userName = "Andre Volpi";

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
      url = {
        "https://oauth2:GITHUB_TOKEN@github.com" = {
          insteadOf = "https://github.com";
        };
      };
    };

    ignores = [ ];

    signing = {
      signByDefault = true;
      key = "XXXXXXXXXX";
    };

    lfs = { enable = true; };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
  };
}

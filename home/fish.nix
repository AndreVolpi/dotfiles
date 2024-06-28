{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hr
    thefuck
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      # AWS
      set -gx AWS_VAULT_BACKEND pass
      set -gx AWS_VAULT_PASS_PREFIX aws-vault
      set -gx VAULT_LDAP_USER andre.volpi

      # Vi mode
      fish_vi_key_bindings

      # Enable Nix's direnv
      direnv hook fish | source
    '';

    shellAbbrs = { hms = "home-manager switch --flake ~/dotfiles"; };

    functions = {
      fuck = {
        description = "Correct your previous console command";
        body = # fish
          ''
            set -l fucked_up_command $history[1]
            env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
            if [ "$unfucked_command" != "" ]
              eval $unfucked_command
              builtin history delete --exact --case-sensitive -- $fucked_up_command
              builtin history merge
            end
          '';
      };
    };

    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "fish-abbreviation-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "v0.7.0";
          sha256 = "05b5qp7yly7mwsqykjlb79gl24bs6mbqzaj5b3xfn3v2b7apqnqp";
        };
      }
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
          sha256 = "1fvl23y9lylj4nz6k7yfja6v9jlsg8jffs2m5mq0ql4ja5vi5pkv";
        };
      }
      {
        name = "fishbang";
        src = pkgs.fetchFromGitHub {
          owner = "BrewingWeasel";
          repo = "fishbang";
          rev = "4897f481e424b59d3315c39d159eefee828717e6";
          sha256 = "1dkpynk9rmjqkybrzmy758yaabc2p9flyali71yl73jmwh87v8sk";
        };
      }
    ];
  };
}

{ config, pkgs, lib, ... }:

let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-23.05";
  });
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in {
  imports = [ nixvim.homeManagerModules.nixvim ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = let
    nixpkgs2211 = import <nixos-22.11> {
      config = { permittedInsecurePackages = [ "erlang-21.3.8.24" ]; };
    };
    terraform_1_4_5 = pkgs.mkTerraform {
      version = "1.4.5";
      hash = "sha256-mnJ9d3UHAZxmz0i7PH0JF5gA3m3nJxM2NyAn0J0L6u8=";
      vendorHash = "sha256-3ZQcWatJlQ6NVoPL/7cKQO6+YCSM3Ld77iLEQK3jBDE=";
    };
    prevpkgs = import (builtins.fetchGit {
       name = "Packages";
       url = "https://github.com/NixOS/nixpkgs/";
       ref = "refs/heads/nixos-23.05";
       rev = "f21b6f77ac562732a4c9b8d1e5751c97853fe873";
     }) {};
  in with pkgs; [
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
    hr
    thefuck
    openssh

    gita

    aws-vault
    awscli2

    terraform_1_4_5
    terraform-ls
    prevpkgs.terragrunt

    python38
    pyright
    python311Packages.jedi-language-server
    black

    lua5_2
    lua-language-server

    nixpkgs2211.erlangR21
    nixpkgs2211.rebar3
    erlang-ls
    erlfmt

    docker
    nodePackages.dockerfile-language-server-nodejs

    nixd
    nixfmt

    gopls
    sourcekit-lsp
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver
  ];

  home.file = { };

  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      set -gx LD_PRELOAD /lib/x86_64-linux-gnu/libnss_sss.so.2

      # AWS
      set -gx AWS_VAULT_BACKEND pass
      set -gx AWS_VAULT_PASS_PREFIX aws-vault
      set -gx VAULT_LDAP_USER andre.volpi

      # Terraform
      set -gx TERRAFORM_TOOLS_DIR $HOME/projects/liveservices/infrastructure/terraform-tools
      set -gx TG_TF_REGISTRY_TOKEN "glpat-Ko9VLmExNvAdYHRzQPsR"

      # Vi mode
      fish_vi_key_bindings
    '';

    shellAbbrs = {
      hms = "home-manager switch";
    };

    functions = {
      fuck = {
        description = "Correct your previous console command";
        body = /* fish */ ''
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

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      git_metrics = { disabled = false; };
      time = {
        disabled = false;
        format = "🕙[\\[$time\\]]($style) ";
      };
      hostname = { disabled = true; };
      line_break = { disabled = true; };
      username = { disabled = true; };
      terraform = { format = "[🏎💨 $version$workspace]($style) "; };
    };
  };

  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = true;
    historyLimit = 50000;
    escapeTime = 0;
    newSession = true;
    shell = "${pkgs.fish}/bin/fish";

    plugins = with pkgs; [
      tmuxPlugins.onedark-theme
      {
        plugin = tmuxPlugins.better-mouse-mode;
        extraConfig = /* fish */ ''
          set -g @scroll-without-changing-pane "on"
        '';
      }
      {
        plugin = tmuxPlugins.pain-control;
        extraConfig = /* fish */ ''
          set -g @pane_resize "10"
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = /* fish */ ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = /* fish */ ''
      setw -g automatic-rename on   # rename window to reflect current program
      set -g renumber-windows on    # renumber windows when a window is closed
      set -g set-titles on          # set terminal title
      set-option -g set-titles-string "#h ❐ #S ● #I #W"

      bind R source-file '~/.config/tmux/tmux.conf'

      set-option -g status on
      set-option -g status-position top

      bind Enter copy-mode # enter copy mode

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel

      set-option -g automatic-rename-format '#{s/.home.andre.volpi@ca.SEGA.Internal/~/:pane_current_path}'

      # window navigation
      unbind n
      unbind p
      bind -r C-h previous-window # select previous window
      bind -r C-l next-window     # select next window
      bind Tab last-window        # move to last active window

      # toggle mouse
      bind m run "cut -c3- '#{TMUX_CONF}' | sh -s _toggle_mouse"
    '';
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    tmux = { enableShellIntegration = true; };
    defaultCommand = "fd --type f";
    defaultOptions = [ "--height" "40%" "--border" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview" "'file {}; head {}'" ];
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview" "'tree -C {} | head -200'" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
  };

  programs.git = {
    enable = true;
    userEmail = "andre.volpi@creative-assembly.com";
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
        "https://oauth2:GITLAB_TOKEN@cahrh-gitlab.creative-assembly.com" = {
          insteadOf = https://cahrh-gitlab.creative-assembly.com;
        };
        "https://oauth2:GITHUB_TOKEN@github.com" = {
          insteadOf = https://github.com;
        };
      };
    };

    ignores = [ ];

    signing = {
      signByDefault = true;
      key = "EC9829DE50E51516";
    };

    lfs = { enable = true; };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
    pinentryFlavor = "gtk2";
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.onedark.enable = true;

    clipboard.register = "unnamedplus";

    options = {
      showcmd = true; # Show incomplete cmds down the bottom
      showmode = true; # Show current mode down the bottom
      number = true; # Show line numbers
      relativenumber = true; # Show line numbers
      autoread = true; # Reload files changed outside of Vim

      hidden = true; # Hide buffers when not displayed
      cmdheight = 2; # Larger command space
      updatetime = 300; # Shorter update time
      colorcolumn = "120"; # Marks the line length limit

      swapfile = false;
      backup = false;
      writebackup = false;

      scrolloff = 8; # Start scrolling when we're 8 lines away from margins
      sidescrolloff = 15;
      sidescroll = 1;

      mouse = "a";

      incsearch = true; # Find the next match as we type the search
      hlsearch = true; # Highlight searches by default
      ignorecase = true; # Ignore case when searching...
      smartcase = true; # ...unless we type a capital

      autoindent = true;
      smartindent = true;
      smarttab = true;
      expandtab = true;

      linebreak = true; # Wrap lines at convenient points

      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };

    maps = {
      normalVisualOp."<C-h>" = "<C-w>h";
      normalVisualOp."<C-j>" = "<C-w>j";
      normalVisualOp."<C-k>" = "<C-w>k";
      normalVisualOp."<C-l>" = "<C-w>l";
      normalVisualOp."Y" = "y$";
      normal."<A-,>" = {
        action = "<cmd>BufferPrevious<CR>";
        silent = true;
      };
      normal."<A-.>" = {
        action = "<cmd>BufferNext<CR>";
        silent = true;
      };
      normal."<A-<>" = {
        action = "<cmd>BufferMovePrevious<CR>";
        silent = true;
      };
      normal."<A->>" = {
        action = "<cmd>BufferMoveNext<CR>";
        silent = true;
      };
      normal."<A-0>" = {
        action = "<cmd>BufferLast<CR>";
        silent = true;
      };
      normal."<A-c>" = {
        action = "<cmd>BufferClose<CR>";
        silent = true;
      };
    };

    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [ "c" "h" "cpp" "hpp" ];
        command = "setl cindent ts=4 sts=4 sw=4 noet nolist";
      }
      {
        event = [ "FileType" ];
        pattern = [ "asm" ];
        command = "setl ts=8 sts=8 sw=8 noet";
      }
      {
        event = [ "FileType" ];
        pattern = [ "go" ];
        command = "setl ts=4 sts=4 sw=4 noet commentstring=// %s";
      }
      {
        event = [ "FileType" ];
        pattern = [ "make" "automake" ];
        command = "setl ts=4 sts=4 sw=4 noet";
      }
      {
        event = [ "FileType" ];
        pattern = [ "erlang" "javascript" "lua" "python" ];
        command = "setl ts=4 sts=4 sw=4";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      rainbow
      fugitive-gitlab-vim
      vista-vim
      vimwiki
      nvim-scrollview
      friendly-snippets
      neoformat
      vim-numbertoggle
      vim-expand-region
      vim-visual-increment
      text-case-nvim
      context-vim
      train-nvim
      clever-f-vim
      vim-signify
      twilight-nvim
      auto-session
      (fromGitHub "HEAD" "chrisgrieser/nvim-origami")
      (fromGitHub "HEAD" "anuvyklack/keymap-amend.nvim")
      (fromGitHub "HEAD" "anuvyklack/fold-preview.nvim")
      (fromGitHub "HEAD" "elpiloto/telescope-vimwiki.nvim")
      (fromGitHub "HEAD" "drzel/vim-split-line")
      (fromGitHub "HEAD" "rutatang/compter.nvim")
      (fromGitHub "HEAD" "shellRaining/hlchunk.nvim")
      (fromGitHub "HEAD" "calops/hmts.nvim")
      (fromGitHub "HEAD" "yuki-yano/zero.nvim")
    ];

    extraConfigLua = /* lua */ ''
      vim.o.foldenable = false

      vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('highlight_yank', {}),
        desc = 'Hightlight selection on yank',
        pattern = '*',
        callback = function()
          vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
        end,
      })

      -- Rainbow
      vim.g.rainbow_active = "1"

      -- Fugitive
      vim.g.fugitive_gitlab_domains = {"https://cahrh-gitlab.creative-assembly.com"}

      -- Vista
      vim.g.vista_default_executive = "nvim_lsp"
      vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>Vista!!<CR>", {silent = true})

      -- VimWiki
      vim.g.vimwiki_list = {{ path = '~/notes/', synax = 'markdown', ext = '.md' }}

      -- Scrollview
      vim.g.scrollview_excluded_filetypes = {"nerdtree", "chadtree", "vista"}
      vim.g.scrollview_current_only = true
      vim.g.scrollview_signs_on_startup = {"all"}

      -- Neo-tree
      vim.api.nvim_set_keymap("n", "<leader>pf", "<cmd>Neotree toggle reveal focus float<CR>", {silent = true})
      vim.api.nvim_set_keymap("n", "<leader>pb", "<cmd>Neotree toggle reveal focus float buffers<CR>", {silent = true})
      vim.api.nvim_set_keymap("n", "<leader>pg", "<cmd>Neotree toggle reveal focus float git_status<CR>", {silent = true})

      -- Neoformat
      vim.g.neoformat_enabled_erlang = { "erlfmt" }
      vim.g.neoformat_enabled_python = { "black" }
      vim.g.neoformat_enabled_nix = { "nixfmt" }

      -- HlChunk
      require('hlchunk').setup({
        blank = {
          enable = false,
        }
      })

      -- Nvim-Origami
      vim.o.startofline = true
      require("origami").setup ({
      	keepFoldsAcrossSessions = true,
      	pauseFoldsOnSearch = true,
        setupFoldKeymaps = true,
      })

      -- Fold-Preview
      require('fold-preview').setup({
        auto = 400,
        border = "rounded",
      })

      -- Telescope extensions
      require('telescope').load_extension('vimwiki')

      -- Vim-Split-Line
      vim.api.nvim_set_keymap("n", "S", "<cmd>SplitLine<CR>", {noremap = true})

      -- Compter
      require("compter").setup({
        templates = {
          -- for lowercase alphabet
          {
            pattern = [[\l]],
            priority = 0,
            increase = function(content)
              local ansiCode = string.byte(content) + 1
              if ansiCode > string.byte("z") then
                ansiCode = string.byte("a")
              end
              local char = string.char(ansiCode)
              return char, true
            end,
            decrease = function(content)
              local ansiCode = string.byte(content) - 1
              if ansiCode < string.byte("a") then
                ansiCode = string.byte("z")
              end
              local char = string.char(ansiCode)
              return char, true
            end,
          },
          -- for uppercase alphabet
          {
            pattern = [[\u]],
            priority = 0,
            increase = function(content)
              local ansiCode = string.byte(content) + 1
              if ansiCode > string.byte("Z") then
                ansiCode = string.byte("A")
              end
              local char = string.char(ansiCode)
              return char, true
            end,
            decrease = function(content)
              local ansiCode = string.byte(content) - 1
              if ansiCode < string.byte("A") then
                ansiCode = string.byte("Z")
              end
              local char = string.char(ansiCode)
              return char, true
            end,
          },
          -- for date format: dd/mm/YYYY
          {
            pattern = [[\d\{2}/\d\{2}/\d\{4}]],
            priority = 100,
            increase = function(content)
              local ts = vim.fn.strptime("%d/%m/%Y", content)
              if ts == 0 then
                return content, false
              else
                ts = ts + 24 * 60 * 60
                return vim.fn.strftime("%d/%m/%Y", ts), true
              end
            end,
            decrease = function(content)
              local ts = vim.fn.strptime("%d/%m/%Y", content)
              if ts == 0 then
                return content, false
              else
                ts = ts - 24 * 60 * 60
                return vim.fn.strftime("%d/%m/%Y", ts), true
              end
            end,
          },
          -- for boolean
          {
            pattern = [[\<\(true\|false\|TRUE\|FALSE\|True\|False\)\>]],
            priority = 100,
            increase = function(content)
              local switch = {
                ["true"] = "false",
                ["false"] = "true",
                ["True"] = "False",
                ["False"] = "True",
                ["TRUE"] = "FALSE",
                ["FALSE"] = "TRUE",
              }
              return switch[content], true
            end,
            decrease = function(content)
              local switch = {
                ["true"] = "false",
                ["false"] = "true",
                ["True"] = "False",
                ["False"] = "True",
                ["TRUE"] = "FALSE",
                ["FALSE"] = "TRUE",
              }
              return switch[content], true
            end,
          }
        },
        fallback = true 
      })

      -- Zero
      require('zero').setup()

      -- Text-Case
      require('textcase').setup({})
      require('telescope').load_extension('textcase')
      vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope text-case-nvim" })
      vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope text-case-nvim" })

      -- Clever-f
      vim.g.clever_f_smart_case = true

      -- Auto-session
      require('auto-session').setup({
        auto_session_root_dir = '~/nvim_sessions/',
        auto_restore_enabled = false,
        auto_session_use_git_branch = true
      })
      require("telescope").load_extension('session-lens')
    '';

    plugins = {
      startify = {
        enable = true;
        bookmarks = ["~/projects/dotfiles/home.nix"];
        sessionPersistence = true;
        sessionDir = "~/nvim_sessions";
        changeToVcsRoot = true;
        changeCmd = "cd";
        sessionSort = true;
      };
      airline = {
        enable = true;
        theme = "onedark";
        powerline = true;
        extensions = {
          hunks.enabled = true;
          fzf.enabled = true;
          nvimlsp.enabled = true;
          vista.enabled = true;
        };
      };
      barbar = {
        enable = true;
        autoHide = false;
        clickable = true;
        sidebarFiletypes = {
          nerdtree = true;
          chadtree = true;
          vista = true;
        };
        icons = {
          filetype = {
            enable = true;
            customColors = false;
          };
        };
        extraOptions = {
          gitsigns = {
            added = {
              enabled = true;
              icon = "+";
            };
            changed = {
              enabled = true;
              icon = "~";
            };
            deleted = {
              enabled = true;
              icon = "-";
            };
          };
        };
      };
      neo-tree = {
        enable = true;
        autoCleanAfterSessionRestore = true;
        closeIfLastWindow = true;
      };
      which-key.enable = true;
      spider = {
        enable = true;
        keymaps.motions = {
          w = "w";
          e = "e";
          b = "b";
          g = "ge";
        };
      };
      notify.enable = true;
      noice = {
        enable = true;
        lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
      };
      telescope = {
        enable = true;
        keymaps = {
          "<C-p>" = "fd";
          "<C-f>f" = "live_grep";
          "<C-f>b" = "current_buffer_fuzzy_find";
          "<leader>b" = "buffers";
        };
        defaults = { display_path = "smart"; };
        extensions = {
          fzf-native = {
            enable = true;
            fuzzy = true;
            caseMode = "smart_case";
          };
        };
      };
      treesitter = {
        enable = true;
        folding = true;
      };
      luasnip.enable = true;
      nvim-cmp = {
        enable = true;
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = /* lua */ ''
              function(fallback)
                local luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end
            '';
          };
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim-lsp-signature-help"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "fuzzy-path"; }
          { name = "rg"; }
          { name = "vimwiki-tags"; }
          { name = "treesitter"; }
          { name = "cmdline"; }
          { name = "cmdline-history"; }
        ];
        snippet.expand = "luasnip";
      };
      lsp = {
        enable = true;
        enabledServers = [
          "dockerls"
          "erlangls"
          "jsonls"
          "jedi_language_server"
          "gopls"
          "lua_ls"
          "nixd"
          "pyright"
          "terraformls"
          "sourcekit"
          "yamlls"
        ];
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>e" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>q" = "setloclist";
          };
          lspBuf = {
            "K" = "hover";
            "gD" = "declaration";
            "<C-k>" = "signature_help";
            "<leader>wa" = "add_workspace_folder";
            "<leader>wr" = "remove_workspace_folder";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>f" = "format";
          };
        };
        onAttach = /* lua */  ''
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        '';
        postConfig = /* lua */ ''
          vim.api.nvim_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", {noremap = true})
          vim.api.nvim_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", {noremap = true})
          vim.api.nvim_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", {noremap = true})
          vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", {noremap = true})
        '';
      };
      commentary.enable = true;
      surround.enable = true;
      fugitive.enable = true;
      gitsigns = {
        enable = true;
        wordDiff = true;
        currentLineBlame = true;

        onAttach = {
          function = /* lua */ ''
            function(bufnr)
              vim.api.nvim_buf_set_keymap(bufnr,"n", "[g", "&diff ? '[g' : '<cmd>Gitsigns prev_hunk<CR>'", {noremap = true, silent = true, expr = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "]g", "&diff ? ']g' : '<cmd>Gitsigns next_hunk<CR>'", {noremap = true, silent = true, expr = true})

              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>hD", "<cmd>lua require'gitsigns'.diffthis('~')<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", {noremap = true, silent = true})

              vim.api.nvim_buf_set_keymap(bufnr,"o", "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", {noremap = true, silent = true})
              vim.api.nvim_buf_set_keymap(bufnr,"x", "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", {noremap = true, silent = true})
            end
          '';
        };
      };
    };
  };
}

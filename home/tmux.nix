{ pkgs, ... }:
{
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
        extraConfig = # fish
          ''
            set -g @scroll-without-changing-pane "on"
          '';
      }
      {
        plugin = tmuxPlugins.pain-control;
        extraConfig = # fish
          ''
            set -g @pane_resize "10"
          '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = # fish
          ''
            set -g @continuum-restore 'on'
          '';
      }
    ];

    extraConfig = # fish
      ''
        setw -g automatic-rename on   # rename window to reflect current program
        set -g renumber-windows on    # renumber windows when a window is closed
        set -g set-titles on          # set terminal title
        set-option -g set-titles-string "❐ #S ● #I #W"

        bind R source-file '~/.config/tmux/tmux.conf'

        set-option -g status on
        set-option -g status-position top

        bind Enter copy-mode # enter copy mode

        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi C-v send -X rectangle-toggle
        bind -T copy-mode-vi y send -X copy-selection-and-cancel
        bind -T copy-mode-vi Escape send -X cancel

        set-option -g automatic-rename-format '#{s/.home.kurumas/~/:pane_current_path}'

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
}

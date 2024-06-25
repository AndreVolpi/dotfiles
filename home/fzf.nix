{
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
}

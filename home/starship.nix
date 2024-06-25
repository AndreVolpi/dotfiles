{
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
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aider-chat-full
  ];

  home.file.".aider.conf.yml".text = /* YAML */ ''
    model: ollama_chat/qwen2.5-coder:32b

    git: true
    auto-commits: false

    watch-files: true
  '';
}

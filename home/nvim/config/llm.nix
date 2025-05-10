{ pkgs, ... }:
let
  fromGitHub = import ../functions/fromGitHub.nix;
in
{
  programs.neovim = {
    plugins = [
      (fromGitHub {
        inherit pkgs;
        owner = "David-Kunz";
        repo = "gen.nvim";
        rev = "c8e1f574d4a3a839dde73a87bdc319a62ee1e559";
        sha256 = "s12r8dvva0O2VvEPjOQvpjVpEehxsa4AWoGHXFYxQlI=";
      })
    ];

    extraLuaConfig = /* lua */ ''
      require('gen').setup({
        model = "codellama:13b",
      })
    '';
  };

  programs.fish.shellInit = /* fish */ ''
    # Check if Ollama container is running
    if not docker ps --format '{{.Names}}' | grep -q '^ollama$'
      # If it's not running, stop and remove any leftover container with the same name
      echo "[fish] Stopping any existing Ollama container..."
      docker stop ollama 2>/dev/null || true
      docker rm ollama 2>/dev/null || true

      echo "[fish] Starting Ollama..."
      # Create a Docker volume if not present
      docker volume create ollama_data >/dev/null
      # Run Ollama container if it's not running
      docker run -d --name ollama -p 11434:11434 -v ollama_data:/root/.ollama ollama/ollama:latest
      # Ensure Ollama is fully started before pulling the model
      sleep 5  # Adjust sleep if needed to ensure Ollama is fully up and ready
    end

    # Now, pull the model if it's not already present
    if not docker exec ollama ollama list | grep -q 'codellama.*13b'
      echo "[fish] Pulling codellama:13b model..."
      docker exec ollama ollama pull codellama:13b
    end
  '';
}

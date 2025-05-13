{ pkgs, ... }:
let
  fromGitHub = import ../functions/fromGitHub.nix;
in
{
  programs.neovim = {
    plugins = [
      pkgs.vimPlugins.plenary-nvim
      (fromGitHub {
        inherit pkgs;
        owner = "olimorris";
        repo = "codecompanion.nvim";
        rev = "d19670a44c35e9ba0674cc7a25ff3b8f22bbf062";
        sha256 = "QaMhacXZVnrn6yEbREHgaQeClCFt+han9uIbQBpc1vw=";
      })
    ];

    extraLuaConfig = /* lua */ ''
      -- Enable fidget notification of LLM calls and progress
      local progress = require("fidget.progress")

      local M = {}

      function M:init()
        local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequestStarted",
          group = group,
          callback = function(request)
            local handle = M:create_progress_handle(request)
            M:store_progress_handle(request.data.id, handle)
          end,
        })

        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequestFinished",
          group = group,
          callback = function(request)
            local handle = M:pop_progress_handle(request.data.id)
            if handle then
              M:report_exit_status(handle, request)
              handle:finish()
            end
          end,
        })
      end

      M.handles = {}

      function M:store_progress_handle(id, handle)
        M.handles[id] = handle
      end

      function M:pop_progress_handle(id)
        local handle = M.handles[id]
        M.handles[id] = nil
        return handle
      end

      function M:create_progress_handle(request)
        return progress.handle.create({
          title = " Requesting assistance (" .. request.data.strategy .. ")",
          message = "In progress...",
          lsp_client = {
            name = M:llm_role_title(request.data.adapter),
          },
        })
      end

      function M:llm_role_title(adapter)
        local parts = {}
        table.insert(parts, adapter.formatted_name)
        if adapter.model and adapter.model ~= "" then
          table.insert(parts, "(" .. adapter.model .. ")")
        end
        return table.concat(parts, " ")
      end

      function M:report_exit_status(handle, request)
        if request.data.status == "success" then
          handle.message = "Completed"
        elseif request.data.status == "error" then
          handle.message = " Error"
        else
          handle.message = "󰜺 Cancelled"
        end
      end
      -- End of the LLM progress logic

      require('codecompanion').setup({
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = 'http://localhost:11434'
              },
              schema = {
                model = {
                  default = 'codellama:7b',
                },
              },
            })
          end,
        },
      strategies = {
          chat = {
            adapter = 'ollama',
          },
            inline = {
            adapter = 'ollama',
          },
          agent = {
            adapter = 'ollama',
          },
          -- useless comment, remove
        },
        opts = {
          log_level = 'INFO',
        },
      })

      M:init()
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

    # Now, pull codellama:13b if it's not already present
    if not docker exec ollama ollama list | grep -q 'codellama.*13b'
      echo "[fish] Pulling codellama:13b model..."
      docker exec ollama ollama pull codellama:13b
    end

    # Now, pull codellama:7b if it's not already present
    if not docker exec ollama ollama list | grep -q 'codellama.*7b'
      echo "[fish] Pulling codellama:7b model..."
      docker exec ollama ollama pull codellama:7b
    end
  '';
}

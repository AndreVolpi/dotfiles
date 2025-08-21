return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  init = function()
    local telescope = require("telescope")
    telescope.load_extension("ui-select")
    telescope.load_extension("session-lens")
    telescope.load_extension("textcase")

    local map = vim.keymap.set
    map("n", "<leader>fd", "<cmd>Telescope fd<cr>")
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    map("n", "<leader>ff", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
    map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    map("n", "<leader>fr", "<cmd>Telescope resume<cr>")
  end,
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        display_path = "smart",
        find_command = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case", "--hidden",
          "--glob", "!**/.git/*", "--glob", "!**/node_modules/*"
        },
      },
      extensions = {
        fzf = { case_mode = "smart_case", fuzzy = true },
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
      },
      pickers = {
        fd = {
          find_command = {
            "rg", "--files", "--hidden",
            "--glob", "!**/.git/*", "--glob", "!**/node_modules/*"
          },
        },
      },
    })
  end,
}

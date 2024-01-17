return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "xiyaowong/telescope-emoji.nvim",
      config = function()
        require("telescope").load_extension("emoji")
      end,
    },
  },
  keys = {
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
    { "<leader>fk", "<cmd>Telescope commands<cr>", desc = "Find commands" },
    { "<leader>cR", "<cmd>Telescope lsp_references<cr>", desc = "Find references" },
    { "<leader>cw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find workspace symbols" },
    { "<leader>n", "<cmd>Telescope notify<cr>", desc = "See notifications" },
    { "<leader>fj", "<cmd>Telescope emoji<cr>", desc = "Find emojis" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
        preview = {
          treesitter = false,
        },
        mappings = {
          i = {
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
      },
    })
  end,
}

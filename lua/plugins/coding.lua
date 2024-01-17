return {
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sj",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
}

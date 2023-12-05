return {
  "danymat/neogen",
  keys = {
    { "<leader>ag", "<CMD>Neogen func<CR>", desc = "Gen func doc" },
    { "<leader>aG", "<CMD>Neogen class<CR>", desc = "Gen class doc" },
  },
  config = function()
    require("neogen").setup({
      snippet_engine = "luasnip",
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
        php = {
          template = {
            annotation_convention = "phpdoc",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        javascript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
        typescriptreact = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
      },
    })
  end,
  cmd = { "Neogen" },
  event = "VeryLazy",
}

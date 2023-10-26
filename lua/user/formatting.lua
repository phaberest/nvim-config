return {
  "stevearc/conform.nvim",
  event = "BufReadPost",
  keys = {
    {
      "<leader>lF",
      function()
        require("conform").format { formatters = { "injected" } }
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  config = function()
    local conform = require "conform"
    conform.setup {
      formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        yaml = { "prettierd" },
        fish = { "fish_indent" },
        lua = { "stylua" },
        python = { "black" },
        sh = { "shfmt" },
        swift = { "swiftformat" },
        tex = { "latexindent" },
        svelte = { "prettierd" },
        rust = { "rustfmt" },
        php = { "php-cs-fixer" },
      },
    }
  end,
}

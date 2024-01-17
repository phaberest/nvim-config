-- add more treesitter parsers
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts, {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })

    vim.list_extend(opts.ensure_installed, {
      "astro",
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "php",
      "phpdoc",
      "python",
      "query",
      "regex",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    })
  end,
}

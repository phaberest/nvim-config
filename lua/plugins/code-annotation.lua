return {
  -- JsDoc generator
  {
    'heavenshell/vim-jsdoc',
    ft = 'javascript,typescript,typescriptreact,svelte',
    cmd = 'JsDoc',
    keys = {
      { '<leader>cj', '<cmd>JsDoc<cr>', desc = 'JsDoc' },
    },
    -- make sure that you will have lehre install locally on plugin folder, refer https://github.com/heavenshell/vim-jsdoc#manual-installation
    build = 'make install',
  },

  { -- generate docstrings
    'danymat/neogen',
    cmd = { 'Neogen' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>ci', '<cmd>Neogen<cr>', desc = 'Neogen - Annotation generator' },
    },
    opts = {
      enabled = true,
      -- Only use luasnip as snippet engine if that is not vscode
      snippet_engine = 'luasnip',
    },
  },
}

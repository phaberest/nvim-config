return {
  {
    'chrisgrieser/nvim-scissors',
    dependencies = 'nvim-telescope/telescope.nvim', -- optional
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets',
    },
    keys = {
      '<Leader>csa',
      '<Leader>cse',
    },
    config = function()
      local present, wk = pcall(require, 'which-key')
      if not present then
        return
      end

      wk.register({
        c = {
          s = {
            name = 'Snippets',
            a = { '<cmd>lua require("scissors").addNewSnippet()<CR>', 'Add new snippet' },
            e = { '<cmd>lua require("scissors").editSnippet()<CR>', 'Edit snippet' },
          },
        },
      }, {
        mode = 'n', -- NORMAL mode
        prefix = '<leader>',
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
      })

      wk.register({
        c = {
          s = {
            name = 'Snippets',
            a = { '<cmd>lua require("scissors").addNewSnippet()<CR>', 'Add new snippet from selection' },
          },
        },
      }, {
        mode = 'x', -- VISUAL mode
        prefix = '<leader>',
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
      })
    end,
  },
}

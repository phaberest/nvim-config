return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'olimorris/neotest-phpunit',
      'theutz/neotest-pest',
      'thenbe/neotest-playwright',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-jest',
    },
    keys = {
      { '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", desc = 'Attach to the nearest test' },
      { '<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", desc = 'Rerun last test' },
      { '<leader>to', "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = 'Toggle Test Output Panel' },
      { '<leader>tp', "<cmd>lua require('neotest').run.stop()<cr>", desc = 'Stop the nearest test' },
      { '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<cr>", desc = 'Toggle Test Summary' },
      { '<leader>tt', "<cmd>lua require('neotest').run.run()<cr>", desc = 'Run the nearest test' },
      { '<leader>tT', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = 'Run test the current file' },
      { '<leader>tw', "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>", desc = 'Watch the current file' },
      { '<leader>tu', "<cmd>lua require('neotest').summary.toggle()<cr>", desc = 'Toggle testing ui' },
    },
    config = function()
      local neotest = require 'neotest'

      neotest.setup {
        icons = {
          failed = '󰅚',
          passed = '󰗡',
          running = '󰐍',
          unknown = '󰘥',
        },
        adapters = {
          require 'neotest-phpunit',
          require 'neotest-pest',
          require('neotest-playwright').adapter {
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          },
          require 'neotest-vitest',
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            jestConfigFile = 'custom.jest.config.ts',
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
  },
}

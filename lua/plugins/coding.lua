return {
  {
    'cshuaimin/ssr.nvim',
    keys = {
      {
        '<leader>sj',
        function()
          require('ssr').open()
        end,
        mode = { 'n', 'x' },
        desc = 'Structural Replace',
      },
    },
  },

  -- Move FAST around the document
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      char = {
        keys = { 'f', 'F', 't', 'T' },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
    },
  },

  -- Close all but the buffer you're in
  {
    'numToStr/BufOnly.nvim',
    keys = {
      { '<leader>bo', '<cmd>BufOnly<CR>', desc = 'Delete all other buffers' },
    },
  },

  -- highlight undo/redo
  { 'tzachar/highlight-undo.nvim', keys = { 'u', '<C-r>' }, config = true },

  -- Github code reviews
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = true,
    cmd = {
      'Octo',
    },
    keys = {
      { '<leader>gp', mode = { 'n' }, desc = 'Github PRs' },
      { '<leader>gpl', mode = { 'n' }, '<cmd>Octo pr list<CR>', desc = 'List Github PRs' },
      { '<leader>gpr', mode = { 'n' }, '<cmd>Octo review start<CR>', desc = 'Start Github PR review' },
      { '<leader>ga', mode = { 'n' }, '<cmd>Octo actions<CR>', desc = 'Github actions' },
      { '<leader>gi', mode = { 'n' }, desc = 'Github issues' },
      { '<leader>gil', mode = { 'n' }, '<cmd>Octo issue list<CR>', desc = 'List Github issues' },
      { '<leader>gio', mode = { 'n' }, '<cmd>Octo issue create<CR>', desc = 'Open new Gihub issue' },
    },
    config = true,
  },

  -- Automatic indentation style detection
  { 'nmac427/guess-indent.nvim', lazy = false, priority = 50, config = true },

  -- Big files over 2mb activate BigFile mode, disabling some plugins.
  {
    'LunarVim/bigfile.nvim',
    enabled = true,
    config = function()
      -- default config
      require('bigfile').setup {
        filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
          'indent_blankline',
          'illuminate',
          'lsp',
          'treesitter',
          'syntax',
          'matchparen',
          'vimopts',
          'filetype',
        },
      }
    end,
  },
}

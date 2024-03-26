return {
  {
    'anuvyklack/windows.nvim',
    event = 'WinEnter',
    dependencies = 'anuvyklack/middleclass',
    cmd = {
      'WindowsMaximize',
      'WindowsMaximizeVertically',
      'WindowsMaximizeHorizontally',
      'WindowsEqualize',
      'WindowsEnableAutowidth',
      'WindowsDisableAutowidth',
      'WindowsToggleAutowidth',
    },
    keys = {
      { '<leader>wh', '<cmd>WindowsMaximizeHorizontally<cr>', desc = 'Maximize Windows Horizontally' },
      { '<leader>wm', '<cmd>WindowsMaximize<cr>', desc = 'Maximize Windows' },
      { '<leader>wt', '<cmd>WindowsToggleAutowidth<cr>', desc = 'Toggle Auto Width' },
      { '<leader>wv', '<cmd>WindowsMaximizeVertically<cr>', desc = 'Maximize Window Vertically' },
      { '<leader>w=', '<cmd>WindowsEqualize<cr>', desc = 'EqualizeWindows' },
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup {
        animation = { enable = false },
        autowidth = {
          winwidth = 10,
        },
        ignore = {
          buftype = { 'quickfix', 'help' },
          filetype = { '', 'toggleterm', 'neotest-summary', 'blame' },
        },
      }
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}

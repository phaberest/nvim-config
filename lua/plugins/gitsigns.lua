return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    keys = {
      { ']h', ':Gitsigns next_hunk<CR>', desc = 'Next git hunk' },
      { '[h', ':Gitsigns prev_hunk<CR>', desc = 'Previous git hunk' },
      { '<leader>ghp', ':Gitsigns preview_hunk<CR>', desc = 'Preview git hunk' },
      { '<leader>gb', ':Gitsigns blame_line<CR>', desc = 'Git blame on this line' },
    },
    lazy = false,
    opts = {
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      current_line_blame = true,
      max_file_length = 4000, -- Disable if file is longer than this (in lines)
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
      signs = {
        untracked = { --
          hl = 'GitSignsAdd',
          text = '┃',
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn',
        },
        add = { --
          hl = 'GitSignsAdd',
          text = '┃',
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn',
        },
        change = {
          hl = 'GitSignsChange',
          text = '┃',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
        delete = {
          hl = 'GitSignsDelete',
          text = '_',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          hl = 'GitSignsDelete',
          text = '‾',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          hl = 'GitSignsDelete',
          text = '┃',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

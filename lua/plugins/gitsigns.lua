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
        border = { '', '', '', ' ' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '┄' },
        untracked = { text = '┊' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

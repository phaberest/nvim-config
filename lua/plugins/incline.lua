return {
  'b0o/incline.nvim',
  dependencies = { 'nvim-web-devicons' },
  config = function()
    require('incline').setup {
      hide = {
        cursorline = true,
        focused_win = false,
        only_win = false,
      },
      window = {
        padding = 0,
        margin = {
          horizontal = 0,
          vertical = 0,
        },
        placement = {
          horizontal = 'right',
          vertical = 'top',
        },
        winhighlight = {
          active = { Normal = { guifg = vim.g.terminal_color_0, guibg = vim.g.terminal_color_2 } },
          inactive = { Normal = { guifg = vim.g.terminal_color_0, guibg = vim.g.terminal_color_4 } },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local modified = vim.bo[props.buf].modified
        local buffer = {
          { filename, gui = modified and 'bold,italic' or 'bold' },
          ' ',
          guibg = '#444',
        }
        return buffer
      end,
    }
  end,
}

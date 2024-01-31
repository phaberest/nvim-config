return {
  "b0o/incline.nvim",
  opts = {
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
        horizontal = "right",
        vertical = "top",
      },
      winhighlight = {
        active = { Normal = { guifg = vim.g.terminal_color_0, guibg = vim.g.terminal_color_2 } },
        inactive = { Normal = { guifg = vim.g.terminal_color_0, guibg = vim.g.terminal_color_4 } },
      },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
      local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"

      local buffer = {
        { ft_icon, guifg = ft_color },
        { " " },
        { filename, gui = modified },
      }
      return buffer
    end,
  },
  event = "VeryLazy",
}

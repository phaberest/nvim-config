local M = {
  "nvim-lualine/lualine.nvim",
  commit = "0050b308552e45f7128f399886c86afefc3eb988",
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  dependencies = {
    {
      "famiu/bufdelete.nvim",
      commit = "8933abc09df6c381d47dc271b1ee5d266541448e",
    },
  },
}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
  }

  -- local filetype = {
  --   "filetype",
  --   icons_enabled = false,
  -- }

  -- local location = {
  --   "location",
  --   padding = 0,
  -- }

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  lualine.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        {
          'buffers',
          use_mode_colors = true,
          symbols = {
            modified = '•',
            alternate_file = '',
            directory = '',
          },
        }
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = { diagnostics, "branch", diff },
      lualine_y = { spaces, "progress" },
      lualine_z = { "mode" },
    },
  }
end

return M

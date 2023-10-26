local M = {
  "nvim-lualine/lualine.nvim",
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
      disabled_filetypes = { "alpha", "dashboard", "[No Name]", "Telescope", "NvimTree" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        {
          "filename",
          path = 1,
          colored = false,
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = { { "b:gitsigns_head", icon = "" }, diff },
      lualine_y = {
        spaces,
        {
          "fileformat",
          icons_enabled = true,
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
      },
      lualine_z = { "mode" },
    },
    tabline = {
      lualine_a = {
        {
          "buffers",
          use_mode_colors = true,
          symbols = {
            modified = " ●",
            alternate_file = "",
            directory = "",
          },

          filetype_names = {
            NvimTree = 'NvimTree',
            TelescopePrompt = 'Telescope',
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = { diagnostics },
      lualine_y = {
        { "aerial", sep = " | " },
        "filetype",
      },
      lualine_z = { "progress" },
    },
  }
end

return M

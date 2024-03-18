return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- {
  --   'EdenEast/nightfox.nvim',
  --   opts = {
  --     options = {
  --       styles = {
  --         comments = 'italic',
  --         keywords = 'bold',
  --         types = 'italic,bold',
  --       },
  --     },
  --   },
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   init = function()
  --     vim.cmd.colorscheme 'nightfox'
  --   end,
  -- },
  -- {
  --   'rebelot/kanagawa.nvim',
  --   lazy = true,
  --   opts = {
  --     -- Remove gutter background
  --     colors = {
  --       theme = {
  --         all = {
  --           ui = {
  --             bg_gutter = 'none',
  --           },
  --         },
  --       },
  --     },
  --     overrides = function(colors)
  --       local theme = colors.theme
  --       return {
  --         -- Transparent background
  --         NormalFloat = { bg = 'none' },
  --         FloatBorder = { bg = 'none' },
  --         FloatTitle = { bg = 'none' },
  --
  --         -- Borderless telescope
  --         TelescopeTitle = { fg = theme.ui.special, bold = true },
  --         TelescopePromptNormal = { bg = theme.ui.bg_p1 },
  --         TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
  --         TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
  --         TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
  --         TelescopePreviewNormal = { bg = theme.ui.bg_dim },
  --         TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
  --       }
  --     end,
  --   },
  -- },
}
-- vim: ts=2 sts=2 sw=2 et

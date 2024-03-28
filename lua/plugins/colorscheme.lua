return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      options = {
        styles = {
          comments = 'italic',
          keywords = 'bold',
          types = 'italic,bold',
        },
      },
    },
  },
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option('background', 'dark')
        vim.cmd 'colorscheme duskfox'
      end,
      set_light_mode = function()
        vim.api.nvim_set_option('background', 'light')
        vim.cmd 'colorscheme dawnfox'
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

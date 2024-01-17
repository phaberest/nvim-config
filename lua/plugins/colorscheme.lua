return {
  -- colorscheme
  { "Shatur/neovim-ayu" },
  -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  -- { "rebelot/kanagawa.nvim" },

  -- Configure LazyVim to load the kanagawa theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
      -- colorscheme = "moonfly",
      -- colorscheme = "kanagawa-wave",
    },
  },
}

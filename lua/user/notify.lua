return {
  "rcarriga/nvim-notify",
  opts = {
    render = "wrapped-compact",
    stages = "slide",
  },
  config = function()
    vim.notify = require "notify"
  end,
  event = "VeryLazy",
}

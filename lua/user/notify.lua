return {
  "rcarriga/nvim-notify",
  opts = {
    render = "wrapped-compact",
    stages = "slide",
  },
  config = function()
    local notify = require "notify"

    notify.setup {
      timeout = 1000,
      render = "compact",
    }
    vim.notify = notify
  end,
  event = "VeryLazy",
}

return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    vim.list_extend(opts, {
      render = "wrapped-compact",
      stages = "slide",
      timeout = 3000,
    })
  end,
}

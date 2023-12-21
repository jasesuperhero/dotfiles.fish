return {
  "rcarriga/nvim-notify",
  opts = function()
    return {
      render = "compact",
      timeout = 2000,
      stages = "slide",
    }
  end,
  config = function(_, opts)
    local notify = require "notify"
    notify.setup(opts)
    vim.notify = notify
  end,
}

return {
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
    opts = {
      timeout = 3000,
      render = "compact",
      stages = "fade",
    },
  },
}

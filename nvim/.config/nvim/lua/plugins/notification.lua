return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    timeout = 3000,
    stages = "slide",
    render = "wrapped-compact",
    max_width = 50,
    background_colour = "#000000",
  },
  init = function()
    vim.notify = require("notify")
  end,
}

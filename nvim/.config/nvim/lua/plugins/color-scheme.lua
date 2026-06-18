return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night", -- Choose between "storm", "night", "moon", or "day"
      transparent = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}

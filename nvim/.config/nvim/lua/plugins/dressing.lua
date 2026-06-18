return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "Input:",
      trim_prompt = true,
      title_pos = "left",
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf", "builtin" },
    },
  },
}

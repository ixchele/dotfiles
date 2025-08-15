-- ~/.config/nvim/lua/config/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd" }, -- LSP à installer automatiquement
        automatic_installation = true,
      })
    end
  }
}

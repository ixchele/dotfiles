require("config.lazy")
-- Force Neovim à utiliser des bordures arrondies sur TOUTES les fenêtres flottantes LSP natives
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
-- Force TOUTES les fenêtres flottantes de diagnostics/LSP à être arrondies
vim.diagnostic.config({ float = { border = "rounded" } })

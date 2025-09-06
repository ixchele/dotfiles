return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capapilities = require('blink.cmp').get_lsp_capabilities()

			require("lspconfig").clangd.setup {
				capabilities = capapilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
					"--fallback-style=microsoft",
				},
			}
			require("lspconfig").lua_ls.setup { capabilities = capapilities }

			vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format() end)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local builtin = require("telescope.builtin")

					-- Telescope LSP mappings avec position_encoding
					map("gd", function()
						builtin.lsp_definitions({ position_params = { position_encoding = "utf-16" } })
					end, "[G]oto [D]efinition")

					map("gr", function()
						builtin.lsp_references({ position_params = { position_encoding = "utf-16" } })
					end, "[G]oto [R]eferences")

					map("gI", function()
						builtin.lsp_implementations({ position_params = { position_encoding = "utf-16" } })
					end, "[G]oto [I]mplementation")

					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("<leader>ds", function()
						builtin.lsp_document_symbols({ position_params = { position_encoding = "utf-16" } })
					end, "[D]ocument [S]ymbols")

					map("<leader>ws", function()
						builtin.lsp_dynamic_workspace_symbols({ position_params = { position_encoding = "utf-16" } })
					end, "[W]orkspace [S]ymbols")

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("<leader>D", function()
						builtin.lsp_type_definitions({ position_params = { position_encoding = "utf-16" } })
					end, "Type [D]efinition")

					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Document Highlight
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Inlay Hints toggle
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
			})
		end,
	}
}

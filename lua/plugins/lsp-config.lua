return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			mason_lspconfig.setup({
				-- 1. THE WEB DEV + CPP STACK
				ensure_installed = {
					"lua_ls", -- Lua
					"clangd", -- C++
					"ts_ls", -- JavaScript / TypeScript
					"pyright", -- Python
					"html", -- HTML
					"cssls", -- CSS
					"tailwindcss", -- Tailwind CSS
				},

				-- 2. HANDLERS (The Fixes)
				handlers = {
					-- Default handler (applies to things like html, css, pyright, etc.)
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- Fix for C++ (Offset Encoding)
					["clangd"] = function()
						lspconfig.clangd.setup({
							capabilities = capabilities,
							cmd = { "clangd", "--offset-encoding=utf-16" },
						})
					end,

					-- Fix for Lua (Undefined global 'vim')
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
				},
			})

			-- Add this inside the config function of lsp-config.lua
			vim.diagnostic.config({
				virtual_text = true, -- <--- THIS enables the inline text
				signs = true, -- Keeps the "E" / "W" in the gutter
				underline = true, -- Underlines the error in code
				update_in_insert = false, -- False = wait until you stop typing to show error (less distracting)
				severity_sort = true,
			})
		end,
	},
	-- Separate block for keymaps to keep it clean
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, {})

			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {}) -- Jump to next error
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {}) -- Jump to previous error
		end,
	},
}

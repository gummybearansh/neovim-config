return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main", -- CRITICAL: 'main' is required for Neovim 0.11+
		lazy = false, -- Load immediately to prevent race conditions
		priority = 1000, -- Load before everything else
		config = function()
			require("nvim-treesitter.configs").setup({
				-- We will auto-install these.
				ensure_installed = {
					"c",
					"cpp",
					"python",
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"html",
					"css",
				},

				-- Install synchronously so you see the progress bar (prevents invisible crashes)
				sync_install = true,

				auto_install = true,

				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}

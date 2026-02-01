return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,

		-- ⬇️ FIX 1: Load immediately when opening Markdown files
		event = { "BufReadPre *.md", "BufNewFile *.md" },

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		-- Keep your commands and keys (they are fine)
		cmd = { "ObsidianNew", "ObsidianToday", "ObsidianSearch", "ObsidianQuickSwitch" },
		keys = {
			{
				"<leader>nm",
				function()
					require("utils.refile").refile_note()
				end,
				desc = "Auto-Refile Note based on Tags",
			},
			{
				"<leader>nv",
				function()
					vim.cmd(
						"cd "
							.. vim.fn.expand("~")
							.. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
					)
					vim.cmd("Neotree toggle")
				end,
				desc = "Note: Open Vault",
			},
			{
				"<leader>nn",
				function()
					vim.ui.input({ prompt = "New Note Title: " }, function(input)
						if input and input ~= "" then
							vim.cmd("ObsidianNew " .. input)
						end
					end)
				end,
				desc = "Note: New",
			},
			{ "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Note: Search" },
			{ "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Note: Daily" },
			{ "<leader>nt", "<cmd>ObsidianTemplate<cr>", desc = "Note: Insert Template" },
			{ "<leader>nl", "<cmd>ObsidianLink<cr>", desc = "Note: Link Selection" },
			{ "<leader>nb", "<cmd>ObsidianBacklinks<cr>", desc = "Note: Show Backlinks" },
		},

		config = function()
			require("obsidian").setup({

				-- ⬇️ FIX 2: This block MUST be inside .setup()
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},

				workspaces = {
					{
						name = "SecondBrain",
						path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"),
					},
				},

				templates = {
					folder = "templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
				},

				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9-_]", ""):lower()
					else
						suffix = "untitled"
					end
					return tostring(os.date("%d-%m-%Y")) .. "-" .. suffix
				end,

				daily_notes = {
					folder = "dailies",
					date_format = "%d-%m-%Y",
					template = nil,
				},

				disable_frontmatter = false,

				mappings = {
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
				},

				ui = { enable = false },
			})
		end,
	},
}

return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,

		-- LOAD TRIGGER: Load when you run these commands or press these keys
		cmd = { "ObsidianNew", "ObsidianToday", "ObsidianSearch", "ObsidianQuickSwitch" },
		keys = {
			-- "n" for Notes (The Namespace)
			{
				"<leader>nm",
				function()
					-- Load the module and run the function
					require("utils.refile").refile_note()
				end,
				desc = "Auto-Refile Note based on Tags",
			},
			{
				"<leader>nv",
				function()
					-- Change directory to vault
					vim.cmd("cd " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain")
					-- Open Neo-tree
					vim.cmd("Neotree toggle")
				end,
				desc = "Note: Open Vault",
			},

			-- 1. <leader>nn = New Note (Prompts for title)
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

			-- 2. <leader>ns = Search Notes (Find anything)
			{ "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Note: Search" },

			-- 3. <leader>nd = Daily Note (Your scratchpad)
			{ "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Note: Daily" },

			-- 4. <leader>nt = Template (Insert your CP Template)
			{ "<leader>nt", "<cmd>ObsidianTemplate<cr>", desc = "Note: Insert Template" },

			-- 5. <leader>nl = Link (Paste a link to another note)
			{ "<leader>nl", "<cmd>ObsidianLink<cr>", desc = "Note: Link Selection" },
		},

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("obsidian").setup({

				templates = {
					folder = "templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
				},

				-- POINT TO ICLOUD
				workspaces = {
					{
						name = "SecondBrain",
						path = vim.fn.expand("~") .."/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain",
					},
				},

				-- YOUR CUSTOM FORMAT: DD-MM-YYYY-Title
				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						-- Clean the title: spaces -> underscores, lowercase, keep only alphanumeric
						suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9-_]", ""):lower()
					else
						suffix = "untitled"
					end
					-- Returns: 01-02-2026-my_note_title
					return tostring(os.date("%d-%m-%Y")) .. "-" .. suffix
				end,

				-- DAILY NOTES (Saved in "dailies" folder)
				daily_notes = {
					folder = "dailies",
					date_format = "%d-%m-%Y", -- Matches your preference
					template = nil,
				},

				-- DISABLE FRONTMATTER (Optional)
				-- Set this to true if you don't want the metadata block at the top of every file
				disable_frontmatter = false,

				-- KEYMAPPINGS INSIDE NOTES
				mappings = {
					-- "gf" to follow a [[link]]
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle checkbox with <leader>ch
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
				},

				-- APPEARANCE
				ui = { enable = false }, -- We use 'render-markdown.nvim' instead (it's better)
			})
		end,
	},
}

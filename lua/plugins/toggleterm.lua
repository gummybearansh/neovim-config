return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20, -- Height of the terminal
			open_mapping = [[<C-\>]], -- The key to toggle it (Ctrl + Backslash)
			direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
			shade_terminals = true,
			float_opts = {
				border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
			},
		})

		-- Function to easily run Node
		local Terminal = require("toggleterm.terminal").Terminal
		local node = Terminal:new({ cmd = "node", hidden = true })

		-- CUSTOM: Kill current terminal buffer (so you can restart it in new dir)
		-- You can use this in Normal mode inside the terminal
		vim.api.nvim_set_keymap("n", "<leader>tk", ":bd!<CR>", { noremap = true, silent = true })

		function _NODE_TOGGLE()
			node:toggle()
		end
	end,
}

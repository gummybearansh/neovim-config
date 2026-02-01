return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20, -- Height of the terminal
			open_mapping = [[<C-`>]], -- The key to toggle it (Ctrl + Backslash)
			direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
			shade_terminals = true,
			float_opts = {
				border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
			},
		})

		-- Function to easily run Node
		local Terminal = require("toggleterm.terminal").Terminal
		local node = Terminal:new({ cmd = "node", hidden = true })

		function _NODE_TOGGLE()
			node:toggle()
		end
	end,
}

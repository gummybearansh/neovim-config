local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")

-- CHANGED: We now pass a settings table to disable 'rocks'
require("lazy").setup("plugins", {
	rocks = {
		enabled = false,
		hererocks = false,
	},
})

-- 1. Create the :Cp command
vim.api.nvim_create_user_command("Cp", function()
      vim.cmd("cd /Users/gummybearansh/Desktop/coding-work/CP")
    print("🏆 Entered CP Mode")
end, {})

-- 2. Create the :Tuf command
vim.api.nvim_create_user_command("Tuf", function()
      vim.cmd("cd /Users/gummybearansh/Desktop/coding-work/TUF\\ A2Z")
    print("💪 Entered TUF Mode")
end, {})

-- 3. Create the :Dev command
vim.api.nvim_create_user_command("Dev", function()
      vim.cmd("cd /Users/gummybearansh/Desktop/coding-work/Cohort\\ 3")
    print("💻 Entered Dev Mode")
end, {})

-- 4. Create the :Notes command
vim.api.nvim_create_user_command("Notes", function()
      -- We use vim.fn.expand because of the tricky spaces in iCloud paths
      local path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain")
    vim.cmd("cd " .. path)
    print("🧠 Entered Second Brain")
end, {})

vim.api.nvim_create_user_command("Conf", function()
      -- We use vim.fn.expand because of the tricky spaces in iCloud paths
      local path = vim.fn.expand("/Users/gummybearansh/.config/nvim")
    vim.cmd("cd " .. path)
    print("🧠 Entered nvim Config")
end, {})


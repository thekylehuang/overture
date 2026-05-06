-- Define the path where lazy.nvim will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Conditionally install lazy.nvim from GitHub
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set Leader Key and Local Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup Lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},

	checker = { enabled = false },
})

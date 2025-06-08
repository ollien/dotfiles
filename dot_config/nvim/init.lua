vim.g.mapleader = ","
if vim.g.vscode then
	vim.cmd("source " .. vim.fn.stdpath("config") .. "/vscode.vim")
	return
end

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

local plugin_config = {
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},
	{ import = "plugins" },
}

require("lazy").setup(plugin_config, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("autocmds")

vim.schedule(function()
	require("mappings")
end)

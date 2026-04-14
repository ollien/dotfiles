local with_local = require("configutil.with_local")
local plugin = require("configutil.plugin")

local plugins = {
	plugin("Bekaboo/dropbar.nvim"),
	plugin("catppuccin/nvim"),
	plugin("coffebar/neovim-project"),
	plugin("FabijanZulj/blame.nvim"),
	plugin("folke/snacks.nvim"),
	plugin("folke/todo-comments.nvim"),
	plugin("folke/which-key.nvim"),
	plugin("j-hui/fidget.nvim"),
	plugin("kwkarlwang/bufresize.nvim"),
	plugin("lewis6991/gitsigns.nvim"),
	plugin("lewis6991/satellite.nvim"),
	plugin("linrongbin16/gitlinker.nvim"),
	plugin("MagicDuck/grug-far.nvim"),
	plugin("mason-org/mason.nvim"),
	plugin("neovim/nvim-lspconfig"),
	plugin("NMAC427/guess-indent.nvim"),
	plugin("nvim-lualine/lualine.nvim"),
	plugin("nvim-mini/mini.nvim"),
	plugin("nvim-tree/nvim-tree.lua"),
	plugin("nvim-tree/nvim-web-devicons"),
	plugin("romus204/tree-sitter-manager.nvim"),
	plugin("saghen/blink.cmp"),
	plugin("stevearc/conform.nvim"),
}

return with_local("plugins.lua", { list = true, base_config = plugins })

return {
	"coffebar/neovim-project",
	opts = {
		-- To be overridden per machine
		projects = {},
		picker = {
			type = "telescope",
		},
	},
	init = function()
		vim.opt.sessionoptions:append("globals")
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
		{ "Shatur/neovim-session-manager" },
	},
	priority = 100,
	event = "VeryLazy",
}
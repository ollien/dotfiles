return {
	"coffebar/neovim-project",
	opts = {
		-- projects to be overridden per machine
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
	-- Cannot use "VeryLazy" because otherwise LazyVim throws a buffer detection
	-- error when this picks a buffer
	lazy = false,
}

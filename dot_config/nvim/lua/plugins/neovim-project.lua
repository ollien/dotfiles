return {
	"coffebar/neovim-project",
	opts = {
		-- projects to be overridden per machine
		picker = {
			type = "builtin",
		},
		last_session_on_startup = false,
		dashboard_mode = true,
	},
	init = function()
		vim.opt.sessionoptions:append("globals")
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "folks/snacks.nvim" },
		{ "Shatur/neovim-session-manager" },
	},
	cmd = {
		"NeovimProjectDiscover",
		"NeovimProjectHistory",
		"NeovimProjectLoadRecent",
		"NeovimProjectLoadHist",
		"NeovimProjectLoad",
	},
}

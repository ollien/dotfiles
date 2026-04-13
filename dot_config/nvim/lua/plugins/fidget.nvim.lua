return {
	lazy = false,
	keys = {
		{
			"<leader>nd",
			function()
				require("fidget").notification.clear()
			end,
			desc = "Dismiss fidget notifications",
		},
	},
	opts = {
		notification = {
			override_vim_notify = true,
		},
	},
}

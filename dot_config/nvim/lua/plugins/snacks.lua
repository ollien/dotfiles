return {
	"folke/snacks.nvim",
	priority = 100,
	lazy = false,
	opts = {
		picker = {
			layout = {
				preset = "vscode",
			},
			matcher = {
				frecency = true,
				history_bonus = true,
			},
		},
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
	},
}

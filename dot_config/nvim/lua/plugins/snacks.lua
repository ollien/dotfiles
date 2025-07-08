return {
	"folke/snacks.nvim",
	priority = 100,
	lazy = false,
	opts = {
		picker = {
			layout = {
				preset = "vscode",
			},
			sources = {
				select = {
					config = function(opts)
						local max = vim.o.lines * 0.8 - 10
						-- Hack: this is to work around these two issues
						-- https://github.com/folke/snacks.nvim/issues/2035
						-- https://github.com/folke/snacks.nvim/issues/902#issuecomment-2649284650
						-- the vscode layout has an extra 0.5 of height, so we take the existing max
						-- and use that
						opts.layout.layout.height = math.min(max, opts.layout.layout.height + 0.5)
					end,
					layout = {
						preset = "vscode",
					},
				},
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

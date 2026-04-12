return {
	priority = 100,
	lazy = false,
	keys = {
		{
			"<leader>o",
			function()
				require("snacks").picker.files({ hidden = true })
			end,
			desc = "snacks find files",
		},
		{
			"<leader>ff",
			function()
				require("snacks").picker.files({ hidden = true })
			end,
			desc = "snacks find files",
		},
		{
			"<leader>fk",
			function()
				require("snacks").picker.keymaps()
			end,
			desc = "snacks find keymaps",
		},
		{
			"<leader>fc",
			function()
				require("snacks").picker.commands()
			end,
			desc = "snacks find commands",
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "snacks find buffers",
		},
		{
			"<leader>fr",
			function()
				require("snacks").picker.recent({ filter = { cwd = true } })
			end,
			desc = "snacks find recent",
		},
	},
	opts = {
		picker = {
			layout = {
				preset = "vscode",
			},
			formatters = {
				file = {
					truncate = 80,
				},
			},
			sources = {
				select = {
					config = function(opts)
						-- Not all actions have this property for some reason?
						if opts.layout.layout then
							local max = math.floor(vim.o.lines * 0.8 - 10)
							-- Hack: this is to work around these two issues
							-- https://github.com/folke/snacks.nvim/issues/2035
							-- https://github.com/folke/snacks.nvim/issues/902#issuecomment-2649284650
							-- the vscode layout has an extra 0.5 of height, so we take the existing max
							-- and use that
							opts.layout.layout.height = math.min(max, opts.layout.layout.height + 0.5)
						end
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
	},
}

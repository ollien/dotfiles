return {
	lazy = false,
	priority = 1000,
	---@module 'nordic'
	---@type NordicOptions
	opts = {
		on_palette = function(_) end,
		after_palette = function(_) end,
		on_highlight = function(highlights, palette)
			highlights.Delimiter = { fg = palette.blue1 }
		end,

		visual = { theme = "light" },
	},
	config = function(_, opts)
		require("nordic").setup(opts)

		vim.cmd.colorscheme("nordic")
	end,
}

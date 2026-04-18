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
		integrations = {
			dashboard = false,
			diff_view = false,
			indent_blankline = false,
			leap = false,
			lsp_saga = false,
			mini = false,
			neo_tree = false,
			neorg = false,
			noice = false,
			notify = false,
			nvim_cmp = false,
			nvim_dap = false,
			nvim_tree = false,
			rainbow_delimiters = false,
			telescope = false,
			treesitter_context = false,
			trouble = false,
			vimtex = false,
			visual_whitespace = false,
			which_key = false,
		},
	},
	config = function(_, opts)
		require("nordic").setup(opts)

		vim.cmd.colorscheme("nordic")
	end,
}

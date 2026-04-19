return {
	event = { "BufRead", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	---@module 'todo-comments'
	---@type TodoOptions
	---@diagnostic disable-next-line: missing-fields
	opts = {
		highlight = {
			before = "fg",
			keyword = "fg",
			after = "fg",
		},
	},
}

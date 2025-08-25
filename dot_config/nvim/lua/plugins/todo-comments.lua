return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		highlight = {
			before = "fg",
			keyword = "fg",
			after = "fg",
		},
	},
	event = "BufAdd",
}

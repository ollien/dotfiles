return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			"lsp",
			"treesitter",
			"regex",
		})
	end,
	event = "BufEnter",
}

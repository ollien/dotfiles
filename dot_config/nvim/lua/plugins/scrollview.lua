return {
	"dstein64/nvim-scrollview",
	event = "BufAdd",
	config = function()
		require("scrollview").setup({})
		require("scrollview.contrib.gitsigns").setup({})
	end,
}

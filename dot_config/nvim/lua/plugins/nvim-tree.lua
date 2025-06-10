return {
	"nvim-tree/nvim-tree.lua",
	opts = {
		view = {
			side = "right",
		},
	},
	-- This should lazy load based on commands but the reality is that we get weird races with this
	event = "VeryLazy",
}

return {
	"m4xshen/hardtime.nvim",
	event = "BufEnter",
	dependencies = { "rcarriga/nvim-notify" },
	opts = {
		disable_mouse = false,
		callback = function(msg)
			require("notify")(msg)
		end,
	},
}

return {
	"FabijanZulj/blame.nvim",
	opts = {
		date_format = "%Y-%m-%d",
		format_fn = function(...)
			return require("blame.formats.default_formats").date_message(...)
		end,
	},
	cmd = "BlameToggle",
}

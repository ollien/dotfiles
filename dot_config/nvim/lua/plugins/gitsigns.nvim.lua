return {
	event = { "BufReadPost", "BufNewFile" },
	---@module 'gitsigns'
	---@type Gitsigns.Config
	---@diagnostic disable-next-line: missing-fields
	opts = {
		signs = {
			delete = { text = "󰍵" }, ---@diagnostic disable-line: missing-fields
			changedelete = { text = "󱕖" }, ---@diagnostic disable-line: missing-fields
		},
	},
}

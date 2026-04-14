return {
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("nordic")

		local colors = require("nordic.colors")

		vim.api.nvim_set_hl(0, "Search", { bg = colors.gray5, fg = colors.fg_bright, bold = true })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.yellow.base, fg = colors.black0, bold = true })
		vim.api.nvim_set_hl(0, "CurSearch", { link = "IncSearch" })
	end,
}

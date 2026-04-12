return {
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.everforest_background = "medium"
		vim.g.everforest_enable_italic = false
		vim.cmd.colorscheme("everforest")

		vim.api.nvim_set_hl(0, "DarkPanel", { link = "NvimTreeNormal" })

		vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "NvimTreeNormalFloatBorder", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksPicker", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksNormal", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksNormalNC", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksPickerListBorder", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { link = "DarkPanel" })
		vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder", { link = "DarkPanel" })

		-- Stealing some colors for the nvchad version of this theme
		vim.api.nvim_set_hl(0, "Search", { fg = "#2b3339", bg = "#83c092" })
		vim.api.nvim_set_hl(0, "IncSearch", { fg = "#2b3339", bg = "#dbbc7f" })
		vim.api.nvim_set_hl(0, "CurSearch", { fg = "#2b3339", bg = "#dbbc7f" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#3d454b" })
	end,
}

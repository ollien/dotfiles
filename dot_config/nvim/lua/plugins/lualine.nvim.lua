return {
	opts = {
		options = {
			section_separators = { left = "", right = "" },
			component_separators = { left = "╲", right = "╱" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "filename", path = 1 }, "diagnostics" },
			lualine_c = { "branch", "diff" },
			lualine_x = { "filetype", "lsp_status" },
			lualine_y = {},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	},
}

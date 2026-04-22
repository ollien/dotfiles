local function last_buffer()
	local alt = vim.fn.bufname("#")
	if alt ~= "" then
		return "⇄ " .. vim.fn.fnamemodify(alt, ":t")
	end
	return ""
end

return {
	opts = {
		options = {
			section_separators = { left = "", right = "" },
			component_separators = { left = "╲", right = "╱" },
			theme = "nordic",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "filename", path = 1 }, "diagnostics" },
			lualine_c = { "branch" },
			lualine_x = {
				last_buffer,
				"filetype",
				"lsp_status",
			},
			lualine_y = {},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {
				function()
					return "INACTIVE"
				end,
			},
			lualine_b = { { "filename", path = 1 }, "diagnostics" },
			lualine_c = { "branch", "diff" },
			lualine_x = { "filetype" },
			lualine_y = {},
			lualine_z = { "location" },
		},
	},
}

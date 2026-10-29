local M = {}

function M.relative_path_of_buffer(opts)
	local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	local relative_path = vim.fn.fnamemodify(path, ":~:.")
	local selection_start = vim.fn.line("v")
	local selection_end = vim.fn.line(".")

	if opts and opts.line_no then
		if selection_start == selection_end then
			return relative_path .. ":" .. selection_start
		else
			return relative_path .. ":" .. selection_start .. "-" .. selection_end
		end
	else
		return relative_path
	end
end

return M

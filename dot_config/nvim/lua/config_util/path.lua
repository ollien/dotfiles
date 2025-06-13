local M = {}

function M.get_relative_path()
	local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

	return vim.fn.fnamemodify(path, ":~:.")
end

return M

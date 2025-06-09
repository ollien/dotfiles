local M = {}

local function switch_to_grug_far_buffer(buf)
	local wins = vim.fn.win_findbuf(buf)
	if #wins > 0 then
		vim.api.nvim_set_current_win(wins[1])

		return true
	else
		return false
	end
end

function M.find_or_open_grug_far()
	local buffers = vim.api.nvim_list_bufs()

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_valid(buf) then
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local filename = vim.fn.fnamemodify(buf_name, ":t")

			if filename:match("^Grug FAR") then
				if switch_to_grug_far_buffer(buf) then
					return
				end
			end
		end
	end

	require("grug-far").open()
end

return M

local M = {}
local grug_far = require("grug-far")
local grug_far_instances = require("grug-far.instances")

local function switch_to_buffer_window(buf)
	local wins = vim.fn.win_findbuf(buf)
	if #wins > 0 then
		vim.api.nvim_set_current_win(wins[1])

		return true
	else
		return false
	end
end

function M.find_or_open_grug_far()
	local instance = grug_far_instances.get_instance(nil)
	if instance then
		print(instance)
		switch_to_buffer_window(instance:get_buf())
	else
		grug_far.open()
	end
end

function M.find_or_open_grug_far_with_term(term)
	local instance = grug_far_instances.get_instance(nil)
	if instance then
		instance:update_input_values({ search = term }, false)
		switch_to_buffer_window(instance:get_buf())
		vim.schedule(function()
			instance:goto_first_input()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "m", false)
		end)
	else
		grug_far.open({ prefills = { search = term } })
		vim.schedule(function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "m", false)
		end)
	end
end

function M.find_or_open_grug_far_with_current_word()
	M.find_or_open_grug_far_with_term(vim.fn.expand("<cword>"))
end

return M

-- Taken from https://www.reddit.com/r/neovim/comments/18d6yb6/use_the_builtin_listchars_option_to_implement/
--

local M = {}

function M.update(is_local)
	local listchars_update = function(items)
		local listchars = vim.api.nvim_get_option_value("listchars", {})
		for item, val in pairs(items) do
			if listchars:match(item) then
				listchars = listchars:gsub("(" .. item .. ":)[^,]*", "%1" .. val)
			else
				listchars = listchars .. "," .. item .. ":" .. val
			end
		end
		return listchars
	end
	local new_listchars = ""
	if vim.api.nvim_get_option_value("expandtab", {}) then
		local spaces = vim.api.nvim_get_option_value("shiftwidth", {})
		-- When shiftwidth is 0, vim will use tabstop value
		if spaces == 0 then
			spaces = vim.api.nvim_get_option_value("tabstop", {})
		end
		new_listchars = listchars_update({
			tab = "› ",
			leadmultispace = vim.g.indentline_char .. string.rep(" ", spaces - 1),
		})
	else
		new_listchars = listchars_update({
			tab = vim.g.indentline_char .. " ",
			leadmultispace = "␣",
		})
	end
	local opts = {}
	if is_local then
		opts.scope = "local"
	end
	vim.api.nvim_set_option_value("listchars", new_listchars, opts)
end

return M

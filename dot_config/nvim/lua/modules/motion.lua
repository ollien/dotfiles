local M = {}

local _pending_callback = nil

_G._motion_operator_handler = function()
	vim.cmd('normal! `[v`]"-y')
	local text = vim.fn.getreg("-")
	if _pending_callback then
		_pending_callback(text)
		_pending_callback = nil
	end
end

-- Returns "g@" for use with { expr = true }. Calls callback(text) with the motion's text.
function M.operator(callback)
	_pending_callback = callback
	vim.o.operatorfunc = "v:lua._motion_operator_handler"
	return "g@"
end

return M

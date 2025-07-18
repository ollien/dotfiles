require("nvchad.autocmds")
local listchars = require("config_util.listchars")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		local directory = vim.fn.isdirectory(data.file) == 1

		if directory then
			if directory then
				vim.cmd("cd " .. vim.fn.fnameescape(data.file))
			end

			require("nvim-tree.api").tree.open()
		end
	end,
})

vim.api.nvim_create_autocmd("BufHidden", {
	pattern = "*",
	callback = function(data)
		if
			vim.api.nvim_buf_is_valid(data.buf)
			and vim.bo[data.buf].modifiable
			and not vim.bo[data.buf].readonly
			and vim.bo[data.buf].modified
			and vim.bo[data.buf].buftype == ""
		then
			vim.cmd("write")
		end
	end,
	desc = "Auto-save buffer when leaving it",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		-- Skip if this is a floating window (like hover popups)
		local win = vim.api.nvim_get_current_win()
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			return
		end

		if vim.bo.filetype == "NvimTree" then
			vim.opt_local.statuscolumn = vim.g.nvim_tree_statuscolumn
		else
			vim.opt_local.statuscolumn = vim.g.default_statuscolumn
		end
	end,
})

vim.api.nvim_create_augroup("indent_line", { clear = true })
vim.api.nvim_create_autocmd({ "OptionSet" }, {
	group = "indent_line",
	pattern = { "shiftwidth", "expandtab", "tabstop" },
	callback = function()
		listchars.update(vim.v.option_type == "local")
	end,
})
-- OptionSet is not triggered on startup
-- This may be not needed. The listchars has been set properly in options.vim and it will be sourced
-- on startup.
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = "indent_line",
	callback = function()
		listchars.update(false)
	end,
})

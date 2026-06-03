vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local listchars = require("modules.configutil.listchars")
local listchars_group = vim.api.nvim_create_augroup("ListcharsSetup", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
	group = listchars_group,
	desc = "setup listchars when options change",
	pattern = { "shiftwidth", "expandtab", "tabstop" },
	callback = function(args)
		listchars.update(vim.v.option_type == "local")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = listchars_group,
	desc = "setup listchars when detecting filetype",
	callback = function()
		listchars.update(true)
	end,
})

-- Workaround for https://github.com/neovim/neovim/issues/33781
vim.api.nvim_create_autocmd("BufReadPost", {
	group = listchars_group,
	callback = function()
		vim.schedule(function()
			listchars.update(true)
		end)
	end,
})

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
			and vim.api.nvim_buf_get_name(data.buf) ~= ""
		then
			vim.cmd("write")
		end
	end,
	desc = "Auto-save buffer when leaving it",
})

local statuscolumn_group = vim.api.nvim_create_augroup("StatuscolumnSetup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = statuscolumn_group,
	callback = function()
		local win = vim.api.nvim_get_current_win()
		local config = vim.api.nvim_win_get_config(win)

		if vim.tbl_contains({ "NvimTree", "grug-far" }, vim.bo.filetype) then
			vim.opt_local.statuscolumn = vim.g.relnum_only_statuscolumn
		-- Skip if this is a floating window (like hover popups; nvimtree is an exception)
		elseif config.relative == "" then
			vim.opt_local.statuscolumn = vim.g.default_statuscolumn
		end
	end,
})

-- Workaround for FileType's statuscolumn getting reset
vim.api.nvim_create_autocmd("User", {
	group = statuscolumn_group,
	pattern = "NvimTreeSetup",
	once = true,
	callback = function()
		local api = require("nvim-tree.api")
		api.events.subscribe(api.events.Event.TreeOpen, function()
			local winnr = require("nvim-tree.view").get_winnr()
			if winnr then
				vim.wo[winnr].statuscolumn = vim.g.relnum_only_statuscolumn
			end
		end)
	end,
})

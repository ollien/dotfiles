require("nvchad.autocmds")

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
	pattern = "NvimTree",
	callback = function()
		vim.opt_local.statuscolumn = ""
	end,
})

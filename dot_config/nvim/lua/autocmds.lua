require("nvchad.autocmds")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		-- Only open if no file was opened or if opening a directory
		local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
		local directory = vim.fn.isdirectory(data.file) == 1

		if no_name or directory then
			require("nvim-tree.api").tree.open()
		end
	end,
})

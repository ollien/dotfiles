require("nvchad.autocmds")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		local directory = vim.fn.isdirectory(data.file) == 1

		if no_name or directory then
			if directory then
				vim.cmd("cd " .. vim.fn.fnameescape(data.file))
			end

			require("nvim-tree.api").tree.open()
		end
	end,
})

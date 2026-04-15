vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

vim.keymap.set("n", "<leader>ry", function()
	local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	local relative_path = vim.fn.fnamemodify(path, ":~:.")
	vim.fn.setreg("+", relative_path)

	print("Copied " .. relative_path)
end, { desc = "copy relative path " })

vim.keymap.set("n", "Q", function()
	local word = vim.fn.expand("<cword>")
	if word ~= "" then
		vim.fn.setreg("/", "\\<" .. word .. "\\>")
		vim.opt.hlsearch = true
	end
end, { desc = "highlight current word" })

vim.keymap.set("n", "<leader>q", "<cmd>bd#<cr>", { desc = "close buffer" })
vim.keymap.set("n", "<leader>qa", "<cmd>%bd<cr>", { desc = "close all buffers" })
vim.keymap.set("n", "<leader>qo", "<cmd>%bd | e#<cr>", { desc = "close other buffers" })

vim.keymap.set("n", "<leader><space>", vim.diagnostic.open_float)

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "paste to blackhole" })
vim.keymap.set({ "x", "n" }, "<leader>d", '"_d', { noremap = true, desc = "delete to blackhole" })
vim.keymap.set({ "x", "n" }, "<leader>c", '"_c', { noremap = true, desc = "change to blackhole" })
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "clear highlighting" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	end,
})

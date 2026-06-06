local motion = require("modules.motion")

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
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { noremap = true, desc = "clear highlighting" })

-- https://www.reddit.com/r/neovim/comments/1t6x85i/comment/oklasyx/
vim.keymap.set("v", "<leader>s", function()
	vim.cmd('normal! "-y')
	local text = vim.fn.getreg("-")
	local escaped = vim.fn.escape(text, "/\\.*^$[]~")
	vim.api.nvim_feedkeys(
		":%s/" .. escaped .. "/" .. escaped .. "/g"
			.. vim.api.nvim_replace_termcodes("<Left><Left>", false, false, true),
		"n",
		false
	)
end, { desc = "substitute selection" })

vim.keymap.set("n", "<leader>s*", function()
	local word = vim.fn.expand("<cword>")
	local escaped = vim.fn.escape(word, "/\\.*^$[]~")
	vim.api.nvim_feedkeys(
		":%s/\\<"
			.. escaped
			.. "\\>/"
			.. escaped
			.. "/g"
			.. vim.api.nvim_replace_termcodes("<Left><Left>", false, false, true),
		"n",
		false
	)
end, { desc = "substitute current word" })

vim.keymap.set("n", "<leader>s", function()
	return motion.operator(function(text)
		local escaped = vim.fn.escape(text, "/\\.*^$[]~")
		vim.api.nvim_feedkeys(
			":%s/"
				.. escaped
				.. "/"
				.. escaped
				.. "/g"
				.. vim.api.nvim_replace_termcodes("<Left><Left>", false, false, true),
			"n",
			false
		)
	end)
end, { expr = true, desc = "substitute motion" })

vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
end)

vim.keymap.set("n", "]w", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.WARN })
end)
vim.keymap.set("n", "[w", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN })
end)

vim.keymap.set("n", "]I", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.INFO })
end)
vim.keymap.set("n", "[I", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.INFO })
end)

vim.keymap.set("n", "]h", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.HINT })
end)
vim.keymap.set("n", "[h", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.HINT })
end)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gd", vim.lsp.buf.definition, "[G]oto [d]eclaration")
		map("gD", vim.lsp.buf.declaration, "[G]oto [d]eclaration")
	end,
})

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.default_statuscolumn = "%s%{v:lnum}  %{v:relnum == 0 ? ' ' : v:relnum} "
vim.g.nvim_tree_statuscolumn = ""
vim.g.have_nerd_font = true
vim.g.indentline_char = "·"

vim.o.confirm = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.statuscolumn = vim.g.default_statuscolumn

vim.o.mouse = "nv"

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = false
vim.o.smartcase = false

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.inccommand = "nosplit"
vim.o.scrolloff = 10
vim.o.cursorline = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.spell = true
vim.o.spelloptions = "camel"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.diagnostic.config({
	virtual_text = { prefix = "", current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅙",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "󰋼",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
	underline = true,
	float = { border = "single" },
})

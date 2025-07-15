require("nvchad.options")
pcall(require, "local")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.ignorecase = false
vim.opt.smartcase = false
vim.opt.spell = true
vim.opt.spelloptions = "camel"

vim.o.relativenumber = true
vim.o.number = true

vim.g.default_statuscolumn = "%s%{v:lnum}  %{v:relnum == 0 ? ' ' : v:relnum} "
vim.g.nvim_tree_statuscolumn = ""
vim.g.indentline_char = "·"
vim.o.list = true

vim.o.statuscolumn = vim.g.default_statuscolumn

require("nvchad.configs.lspconfig").defaults()

local config_util = require("config_util.require_all")
local navic = require("nvim-navic")

local servers = { "html", "cssls", "rust_analyzer" }
vim.lsp.enable(servers)

config_util.require_all("configs/lspconfig")

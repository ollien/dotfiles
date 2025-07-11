require("nvchad.configs.lspconfig").defaults()

local config_util = require("config_util.require_all")

local servers = { "html", "cssls", "rust_analyzer", "gleam" }
vim.lsp.enable(servers)

config_util.require_all("configs/lspconfig")

vim.lsp.config("typescript-language-server", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "typescript" },
})

vim.lsp.enable("typescript-language-server")

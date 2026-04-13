local with_local = require("configutil.with_local")

return {
	dependencies = {
		"j-hui/fidget.nvim",
	},
	config = function()
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
			end,
		})

		---@type table<string, vim.lsp.Config>
		local servers = with_local("config/lsp.lua")

		-- Ensure the servers and tools above are installed
		--
		-- To check the current status of installed tools and/or manually install
		-- other tools, you can run
		--    :Mason
		--
		-- You can press `g?` for help in this menu.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			-- You can add other tools here that you want Mason to install
		})

		for name, server in pairs(servers) do
			vim.lsp.config(name, server)
			vim.lsp.enable(name)
		end
	end,
}

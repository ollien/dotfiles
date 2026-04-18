local with_local = require("modules.configutil.with_local")

local function filter_servers(servers)
	local filtered = {}
	for name, config in pairs(servers) do
		if config ~= false then
			filtered[name] = config
		end
	end

	return filtered
end

return {
	dependencies = {
		"j-hui/fidget.nvim",
	},
	config = function()
		---@type table<string, vim.lsp.Config>
		local servers = with_local("config/lsp.lua")
		servers = filter_servers(servers)

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

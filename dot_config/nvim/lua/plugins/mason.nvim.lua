local with_local = require("modules.configutil.with_local")

return {
	"mason-org/mason.nvim",
	---@module 'mason.settings'
	---@type MasonSettings
	---@diagnostic disable-next-line: missing-fields
	dependencies = {
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				automatic_enable = false,
			},
		},
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local ensure_installed = with_local("config/mason.lua", { list = true })

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	end,
}

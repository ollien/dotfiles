local with_local = require("modules.configutil.with_local")

return {
	event = { "BufReadPre", "VeryLazy" },
	config = function()
		local languages = with_local("config/treesitter.lua")

		require("tree-sitter-manager").setup({
			ensure_installed = vim.tbl_keys(languages),
			languages = languages,
			auto_install = true,
		})
	end,
}

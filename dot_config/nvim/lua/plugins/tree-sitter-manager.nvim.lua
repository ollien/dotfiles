local with_local = require("configutil.with_local")

return {
	config = function()
		local languages = with_local("config/treesitter.lua")

		require("tree-sitter-manager").setup({
			ensure_installed = vim.tbl_keys(languages),
			languages = languages,
			auto_install = true,
		})
	end,
}

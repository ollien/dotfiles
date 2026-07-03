local with_local = require("modules.configutil.with_local")
return {
	event = { "BufReadPre", "VeryLazy" },
	config = function()
		local languages = with_local("config/treesitter.lua")
		local sourced_languages = {}
		for lang, config in pairs(languages) do
			if not vim.tbl_isempty(config) then
				sourced_languages[lang] = config
			end
		end
		require("tree-sitter-manager").setup({
			ensure_installed = vim.tbl_keys(languages),
			languages = sourced_languages,
			auto_install = true,
		})
	end,
}

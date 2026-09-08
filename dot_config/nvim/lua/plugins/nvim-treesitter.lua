local with_local = require("modules.configutil.with_local")

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	if not vim.treesitter.language.add(language) then
		return
	end

	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
	if has_indent_query then
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

return {
	-- No lazy support :(
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local language_configs = with_local("config/treesitter.lua")
		for lang, config in pairs(language_configs) do
			if config.filetypes then
				vim.treesitter.language.register(lang, config.filetypes)
			end
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = function()
				local parsers = require("nvim-treesitter.parsers")
				for lang, config in pairs(language_configs) do
					if config.install_info then
						local base_config = parsers[lang] or { tier = 2 }
						parsers[lang] = vim.tbl_deep_extend("force", base_config, {
							install_info = config.install_info,
						})
					end
				end
			end,
		})

		local available_parsers = require("nvim-treesitter").get_available()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf, filetype = args.buf, args.match

				local language = vim.treesitter.language.get_lang(filetype)
				if not language then
					return
				end

				local installed_parsers = require("nvim-treesitter").get_installed("parsers")
				if vim.tbl_contains(installed_parsers, language) then
					-- Enable the parser if it is already installed
					treesitter_try_attach(buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
					require("nvim-treesitter").install(language):await(function()
						treesitter_try_attach(buf, language)
					end)
				else
					-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
					treesitter_try_attach(buf, language)
				end
			end,
		})

		local languages = vim.tbl_keys(language_configs)
		require("nvim-treesitter").install(languages)
	end,
}

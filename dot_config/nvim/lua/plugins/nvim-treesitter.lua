return {
	"nvim-treesitter/nvim-treesitter",

	opts = function(_plugin, opts)
		-- stupid workaround for the fact that the gleam parser broke with the new nvim-treesitter
		-- stolen from https://github.com/rawhat/config/blob/master/config/nvim/lua/plugins/treesitter.lua#L94
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.gleam = {
			install_info = {
				url = "https://github.com/gleam-lang/tree-sitter-gleam",
				revision = "main",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "gleam",
		}

		return vim.tbl_deep_extend("force", opts, {
			ensure_installed = {
				"css",
				"elixir",
				"erlang",
				"gleam",
				"html",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			},
		})
	end,
}

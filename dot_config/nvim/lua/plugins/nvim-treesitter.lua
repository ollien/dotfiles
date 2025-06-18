return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(opts)
		-- stupid workaround for the fact that the gleam parser broke with the new nvim-treesitter
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.gleam = {
			install_info = {
				url = "https://github.com/gleam-lang/tree-sitter-gleam",
				revision = "main",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "gleam",
		}

		vim.tbl_deep_extend("force", opts, {
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

return {
	"Bekaboo/dropbar.nvim",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	event = "BufEnter",
	opts = {
		bar = {
			sources = function(buf, _)
				local sources = require("dropbar.sources")
				local utils = require("dropbar.utils")
				local basename_source = {
					get_symbols = function(buf, win, cursor)
						local path = sources.path.get_symbols(buf, win, cursor)
						if #path == 0 then
							return {}
						else
							return { path[#path] }
						end
					end,
				}
				if vim.bo[buf].ft == "markdown" then
					return {
						basename_source,
						sources.markdown,
					}
				end
				if vim.bo[buf].buftype == "terminal" then
					return {
						sources.terminal,
					}
				end
				return {
					basename_source,
					utils.source.fallback({
						sources.lsp,
						sources.treesitter,
					}),
				}
			end,
		},
	},
}

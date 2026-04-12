return {
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	event = "BufEnter",
	---@type dropbar_configs_t
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

			enable = function(buf, win, _)
				if
					not vim.api.nvim_buf_is_valid(buf)
					or not vim.api.nvim_win_is_valid(win)
					or vim.fn.win_gettype(win) ~= ""
					or (vim.wo[win].winbar ~= "" and vim.wo[win].winbar ~= " ")
					or vim.bo[buf].ft == "help"
				then
					return false
				end

				local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
				if stat and stat.size > 1024 * 1024 then
					return false
				end

				if win ~= vim.api.nvim_get_current_win() then
					return false
				end

				return true
			end,

			attach_events = {
				"TermOpen",
				"BufEnter",
				"BufWinEnter",
				"BufWritePost",
				"FileType",
				"LspAttach",
				"WinEnter",
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("WinLeave", {
			callback = function()
				local win = vim.api.nvim_get_current_win()
				if vim.wo[win].winbar ~= "" and vim.wo[win].winbar ~= " " then
					vim.wo[win].winbar = " "
				end
			end,
		})
	end,
}

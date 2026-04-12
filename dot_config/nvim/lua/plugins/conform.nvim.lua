local with_local = require("configutil.with_local")
local config = with_local("config/formatters.lua")

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	---@module 'conform'
	---@type conform.setupOpts
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			if config.disabled_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end,
		formatters_by_ft = config.formatters_by_filetype,
	},
	init = function()
		vim.api.nvim_create_user_command("ConformToggle", function()
			vim.b.disable_autoformat = not vim.b.disable_autoformat
			vim.notify("Autoformat " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
		end, { desc = "Toggle conform autoformat for current buffer" })
	end,
}

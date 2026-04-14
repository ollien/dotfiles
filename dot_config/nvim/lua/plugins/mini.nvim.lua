return {
	"nvim-mini/mini.nvim",
	config = function()
		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Auto-closing of pairwise characters
		require("mini.pairs").setup()

		require("mini.sessions").setup()

		local session_name = require("configutil.session_name")
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				MiniSessions.write(session_name(vim.fn.getcwd()), { force = true })
			end,
		})
	end,
}

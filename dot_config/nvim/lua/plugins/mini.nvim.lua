return {
	event = "VeryLazy",
	config = function()
		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Auto-closing of pairwise characters
		require("mini.pairs").setup()

		require("mini.sessions").setup({
			-- We do this ourselves to support projects
			autowrite = false,
			verbose = { read = false, write = false, delete = true },
			hooks = {
				pre = {
					write = function()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.b[buf].exclude_from_session then
								vim.api.nvim_buf_delete(buf, { force = true })
							end
						end
					end,
				},
			},
		})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				require("modules.project").save_if_active()
			end,
		})
	end,
}

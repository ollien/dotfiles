local with_local = require("configutil.with_local")
local projects = with_local("config/projects.lua")

return {
	priority = 100,
	lazy = false,
	keys = {
		{
			"<leader>o",
			function()
				require("snacks").picker.files({ hidden = true })
			end,
			desc = "snacks find files",
		},
		{
			"<leader>ff",
			function()
				require("snacks").picker.files({ hidden = true })
			end,
			desc = "snacks find files",
		},
		{
			"<leader>fk",
			function()
				require("snacks").picker.keymaps()
			end,
			desc = "snacks find keymaps",
		},
		{
			"<leader>fc",
			function()
				require("snacks").picker.commands()
			end,
			desc = "snacks find commands",
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "snacks find buffers",
		},
		{
			"<leader>fr",
			function()
				require("snacks").picker.recent({ filter = { cwd = true } })
			end,
			desc = "snacks find recent",
		},
		{
			"<leader>fp",
			function()
				require("snacks").picker.projects()
			end,
			desc = "snacks find recent",
		},
	},
	opts = {
		picker = {
			layout = {
				preset = "vscode",
			},
			formatters = {
				file = {
					truncate = 80,
				},
			},
			sources = {
				select = {
					config = function(opts)
						-- Not all actions have this property for some reason?
						if opts.layout.layout then
							local max = math.floor(vim.o.lines * 0.8 - 10)
							-- Hack: this is to work around these two issues
							-- https://github.com/folke/snacks.nvim/issues/2035
							-- https://github.com/folke/snacks.nvim/issues/902#issuecomment-2649284650
							-- the vscode layout has an extra 0.5 of height, so we take the existing max
							-- and use that
							opts.layout.layout.height = math.min(max, opts.layout.layout.height + 0.5)
						end
					end,
					layout = {
						preset = "vscode",
					},
				},
				projects = {
					dev = projects.roots or {},
					projects = projects.projects or {},
					patterns = projects.patterns or { ".git", "Makefile", "Justfile", "package.json", "Cargo.toml" },
					recent = true,
					confirm = function(picker, item)
						picker:close()
						if not item then
							return
						end

						local session_name = require("configutil.session_name")

						if vim.g.project_loaded then
							-- Save the current session before switching away
							MiniSessions.write(session_name(vim.fn.getcwd()), { force = true })
						end

						vim.g.project_loaded = true

						-- Close current buffers so we don't mix between projects, kill the LSPs so they don't freak out
						for _, client in ipairs(vim.lsp.get_clients()) do
							client:stop(true)
						end
						vim.cmd("%bdelete")

						local dir = vim.fn.fnamemodify(item.file, ":p"):gsub("/$", "")
						vim.fn.chdir(dir)

						pcall(MiniSessions.read, session_name(dir))
					end,
				},
			},
			matcher = {
				frecency = true,
				history_bonus = true,
			},
		},
	},
}

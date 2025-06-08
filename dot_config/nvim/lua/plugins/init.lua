return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"cpea2506/one_monokai.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"rust",
				"elixir",
				"python",
				"markdown",
				"markdown_inline",
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = {
				side = "right",
			},
		},
	},
	{
		"echasnovski/mini.surround",
		version = false,
		keys = { "sa", "sd", "sf", "sF", "sh", "sr", "sn" },
		opts = {},
	},
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		opts = {
			showCompactInputs = true,
			transient = true,
			startInInsertMode = false,
		},
	},
}

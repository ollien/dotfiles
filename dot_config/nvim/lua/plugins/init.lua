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
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				file_ignore_patterns = { ".git", "node_modules" },
				no_ignore = false,
				no_ignore_parent = false,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		opts = {
			enabled = function()
				local disabled = false
				disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
				disabled = disabled or (vim.fn.reg_recording() ~= "")
				disabled = disabled or (vim.fn.reg_executing() ~= "")
				disabled = disabled or require("cmp.config.context").in_treesitter_capture("comment")
				return not disabled
			end,
		},
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
		-- This should lazy load based on commands but the reality is that we get weird races with this
		event = "VeryLazy",
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
			windowCreationCommand = "botright vsplit",
		},
	},
	{
		"kwkarlwang/bufresize.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"tpope/vim-sleuth",
		event = "BufCreate",
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {
			strategies = {
				chat = {
					adapter = "anthropic",
				},
				inline = {
					adapter = "anthropic",
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "BufCreate",
	},
	{
		"coffebar/neovim-project",
		opts = {
			-- To be overridden per machine
			projects = {},
			picker = {
				type = "telescope",
			},
		},
		init = function()
			vim.opt.sessionoptions:append("globals")
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "Shatur/neovim-session-manager" },
		},
		priority = 100,
		event = "VeryLazy",
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {},
		keys = { "<leader>gy" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				before = "fg",
				keyword = "fg",
				after = "fg",
			},
		},
		event = "BufCreate",
	},
}

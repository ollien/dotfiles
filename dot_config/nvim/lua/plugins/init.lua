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
			windowCreationCommand = "botright vsplit",
		},
	},
	{
		"kwkarlwang/bufresize.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nmac427/vim-sleuth",
		event = "BufCreate",
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "claude",
			providers = {
				claude = {
					model = "claude-sonnet-4-0",
				},
			},
			hints = { enabled = false },
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
			"ibhagwan/fzf-lua",
			"stevearc/dressing.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
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
}

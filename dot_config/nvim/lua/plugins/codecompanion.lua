return {
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
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
}

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			elixir = { "mix" },
			javascript = {"prettier"},
			typescript = {"prettier"},
			yaml = {"prettier"},
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}

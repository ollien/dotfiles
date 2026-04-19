return {
	event = "BufReadPost",
	version = "1.*",
	dependencies = {
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			config = function()
				local luasnip = require("luasnip")
				local snippet = luasnip.snippet
				local insert_node = luasnip.insert_node
				local format = require("luasnip.extras.fmt").fmt

				luasnip.add_snippets("elixir", {
					snippet(
						"do",
						format(

							[[
        do
          {}
        end
    ]],
							{
								insert_node(1),
							}
						)
					),
				})
			end,
			opts = {
				vscode_snippets_exclude = { "elixir" },
			},
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		enabled = function()
			return not vim.tbl_contains({ "grug-far" }, vim.bo.filetype)
		end,
		keymap = {
			preset = "enter",

			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
		sources = {
			default = { "lsp", "buffer", "path", "snippets" },
			providers = {
				buffer = {
					async = true,
					opts = {
						get_bufnrs = function()
							return vim.tbl_filter(function(bufnr)
								return vim.bo[bufnr].buftype == ""
							end, vim.api.nvim_list_bufs())
						end,
					},
				},
				lsp = {
					async = true,
					fallbacks = {},
					score_offset = 1000,
				},
			},
		},
		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	},
}

return {
	event = "InsertEnter",
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
		keymap = {
			preset = "enter",
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
		sources = {
			default = { "lsp", "path", "snippets" },
			providers = {
				lsp = {
					async = true,
				},
			},
		},
		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	},
}

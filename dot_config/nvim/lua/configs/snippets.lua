vim.g.vscode_snippets_exclude = { "elixir" }

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

-- Credits to original https://github.com/azemoh/vscode-one-monokai

local M = {}

M.base_30 = {
	white = "#abb2bf",
	darker_black = "#22262d",
	black = "#282c34", --  nvim bg
	black2 = "#252931",
	one_bg = "#282c34", -- real bg
	one_bg2 = "#353b45",
	one_bg3 = "#373b43",
	grey = "#42464e",
	grey_fg = "#565c64",
	grey_fg2 = "#6f737b",
	light_grey = "#6f737b",
	red = "#e06c75",
	baby_pink = "#DE8C92",
	pink = "#e06c75",
	line = "#31353d", -- for lines like vertsplit
	green = "#98c379",
	vibrant_green = "#7eca9c",
	nord_blue = "#81A1C1",
	blue = "#61afef",
	yellow = "#e7c787",
	sun = "#EBCB8B",
	purple = "#c678dd",
	dark_purple = "#c882e7",
	teal = "#519ABA",
	orange = "#e5c07b",
	cyan = "#56b6c2",
	statusline_bg = "#22262e",
	lightbg = "#2d3139",
	pmenu_bg = "#61afef",
	folder_bg = "#61afef",
}

M.base_16 = {
	base00 = "#282c34",
	base01 = "#353b45",
	base02 = "#3e4451",
	base03 = "#545862",
	base04 = "#565c64",
	base05 = "#abb2bf",
	base06 = "#b6bdca",
	base07 = "#c8ccd4",
	base08 = "#e06c75",
	base09 = "#d19a66",
	base0A = "#e5c07b",
	base0B = "#98c379",
	base0C = "#56b6c2",
	base0D = "#61afef",
	base0E = "#e06c75",
	base0F = "#be5046",
}

M.type = "dark"

M = require("base46").override_theme(M, "one_monokai")

return M

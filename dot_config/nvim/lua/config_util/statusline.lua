-- A lot of this is adapted from https://github.com/NvChad/ui/blob/b7c656064ec54f77bc6c75e4c51108ba451e6d7a/lua/nvchad/stl/default.lua

local utils = require("nvchad.stl.utils")
local nvconfig = require("nvconfig")

local M = {}

local function get_separator()
	local sep_style = nvconfig.ui.statusline.separator_style
	local sep_icons = utils.separators
	local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

	return separators["right"]
end

local function get_relative_path()
	local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

	return vim.fn.fnamemodify(path, ":~:.")
end

function M.relative_file()
	local sep_r = get_separator()

	local icon = utils.file()[1]
	local name = get_relative_path()

	return "%#St_file# " .. icon .. " " .. name .. " %#St_file_sep#" .. sep_r
end

return M


local lua_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua")

local function load_config(relative_path)
	local ok, result = pcall(dofile, vim.fs.joinpath(lua_dir, relative_path))
	if not ok then
		return {}
	end

	if type(result) ~= "table" then
		error("Config module '" .. relative_path .. "' must return a table")
	end
	return result
end

return function(path, opts)
	opts = opts or {}
	local base_config = opts.base_config or load_config(path)
	local local_config = load_config(vim.fs.joinpath("_local", path))
	if opts.list then
		return vim.list_extend(vim.deepcopy(base_config), local_config)
	else
		return vim.tbl_deep_extend("force", base_config, local_config)
	end
end

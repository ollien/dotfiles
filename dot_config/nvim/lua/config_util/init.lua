local M = {}

function M.require_all(base_dir)
	local lua_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lua")
	local files = vim.fs.find(function(name)
		return name:match("%.lua$")
	end, { path = vim.fs.joinpath(lua_path, base_dir), limit = math.huge })

	for _, full_path in ipairs(files) do
		local path = vim.fs.relpath(lua_path, full_path)
		local basename = vim.fs.basename(path)
		if basename ~= "init.lua" then
			local module_path = string.gsub(path:gsub("%.lua$", ""), "/", ".")
			require(module_path)
		end
	end
end

return M

local with_local = require("configutil.with_local")

return function(name)
	local short_name = name:match(".+/(.+)") or error("Invalid plugin name: " .. name)
	local config = with_local(vim.fs.joinpath("plugins", short_name .. ".lua"))
	return vim.tbl_extend("force", { name }, config)
end

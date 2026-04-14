return function(dir)
	local normalized = vim.fs.normalize(vim.fn.resolve(vim.fn.fnamemodify(dir, ":p")))
	local name = normalized:gsub("/$", ""):gsub("[/\\]", "%%"):gsub(":", "")

	return name
end

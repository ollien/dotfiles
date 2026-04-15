local M = {}

local function session_name(dir)
	local normalized = vim.fs.normalize(vim.fn.resolve(vim.fn.fnamemodify(dir, ":p")))
	return normalized:gsub("/$", ""):gsub("[/\\]", "%%"):gsub(":", "")
end

function M.save_if_active()
	if vim.g.ollien_project_loaded == vim.fn.getcwd() then
		MiniSessions.write(session_name(vim.fn.getcwd()), { force = true })
	end
end

function M.switch(raw_dir)
	local dir = vim.fn.fnamemodify(raw_dir, ":p"):gsub("/$", "")

	M.save_if_active()

	for _, client in ipairs(vim.lsp.get_clients()) do
		client:stop(true)
	end
	vim.cmd("%bdelete")

	vim.fn.chdir(dir)
	vim.g.ollien_project_loaded = dir

	pcall(MiniSessions.read, session_name(dir))
end

return M

local M = {}

local function session_name(dir)
	local normalized = vim.fs.normalize(vim.fn.resolve(vim.fn.fnamemodify(dir, ":p")))
	local name = normalized:gsub("/$", ""):gsub("[/\\]", "%%"):gsub(":", "")

	return name
end

function M.save_if_active()
	if vim.g.ollien_project_loaded == vim.fn.getcwd() then
		MiniSessions.write(session_name(vim.fn.getcwd()), { force = true })
	end
end

function M.switch(raw_dir)
	local dir = vim.fn.fnamemodify(raw_dir, ":p"):gsub("/$", "")

	-- Save the current session before switching away
	M.save_if_active()

	-- Close current buffers so we don't mix between projects, kill the LSPs so they don't freak out
	for _, client in ipairs(vim.lsp.get_clients()) do
		client:stop(true)
	end
	vim.cmd("silent %bdelete")

	vim.fn.chdir(dir)
	-- Use vim.fn.cwd() to ensure things match what save_if_active wil get
	vim.g.ollien_project_loaded = vim.fn.getcwd()

	pcall(MiniSessions.read, session_name(dir))
end

return M

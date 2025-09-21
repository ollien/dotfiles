require("nvchad.mappings")

local path = require("config_util.path")

local map = vim.keymap.set

local function find_files()
	require("extra.fff_snacks").fff()
end

local function set_rightmost_window_width()
	local last_win = vim.fn.winnr("$")
	vim.cmd(last_win .. "wincmd w")
	vim.cmd("vertical resize 50%")
end

-- Navigation / Editing
map("x", "<leader>p", '"_dP', { desc = "paste to blackhole" })
map({ "x", "n" }, "<leader>d", '"_d', { noremap = true, desc = "delete to blackhole" })
map({ "x", "n" }, "<leader>c", '"_c', { noremap = true, desc = "change to blackhole" })
map("n", "<leader>h", "<cmd>noh<cr>", { desc = "clear highlighting" })
-- Remove vertical terminal mapping since we just overrode the horizontal one
vim.keymap.del("n", "<leader>v", {})
map("n", "<leader><space>", vim.diagnostic.open_float)

map("n", "<leader>ry", function()
	local relative_path = path.get_relative_path()
	vim.fn.setreg("+", relative_path)

	print("Copied " .. relative_path)
end, { desc = "copy relative path " })
map("n", "Q", function()
	local word = vim.fn.expand("<cword>")
	if word ~= "" then
		vim.fn.setreg("/", "\\<" .. word .. "\\>")
		vim.opt.hlsearch = true
	end
end, { desc = "highlight current word" })

-- Buffer and window management
map("n", "<leader>wq", set_rightmost_window_width, { desc = "set rightmost window to 25% width" })
map("n", "<leader>q", "<cmd>bd#<cr>", { desc = "close buffer" })
map("n", "<leader>qa", "<cmd>%bd<cr>", { desc = "close all buffers" })
map("n", "<leader>qo", "<cmd>%bd | e#<cr>", { desc = "close other buffers" })

-- Telescope
map("n", "<leader>o", find_files, { noremap = true, desc = "snacks find files" })
map("n", "<leader>ff", find_files, { noremap = true, desc = "snacks find files" })
map("n", "<leader>fp", "<cmd>NeovimProjectDiscover<cr>", { noremap = true, desc = "telescope find projects" })

map("n", "<leader>fk", function()
	require("snacks").picker.keymaps()
end, { noremap = true, desc = "snacks find keymaps" })

map("n", "<leader>fc", function()
	require("snacks").picker.commands()
end, { noremap = true, desc = "snacks find commands" })

map("n", "<leader>fb", function()
	require("snacks").picker.buffers()
end, { noremap = true, desc = "snacks find buffers" })

map("n", "<leader>fr", function()
	require("snacks").picker.resume()
end, { noremap = true, desc = "snacks resume" })

-- Grug Far
map("n", "<leader>fw", function()
	require("config_util.grug_far").toggle_grug_far()
end, { noremap = true, desc = "find and replace" })

map("n", "<leader>f*", function()
	require("config_util.grug_far").find_or_open_grug_far_with_current_word()
end, { noremap = true, desc = "find and replace current word" })

-- Code Companion
map("n", "<leader>ae", "<cmd>CodeCompanion<cr>")
map("x", "<leader>ae", "<cmd>'<,'>CodeCompanion<cr>")

map("n", "<leader>ac", function()
	require("codecompanion").chat()
end)

map("n", "<leader>ar", function()
	require("codecompanion").last_chat()
end)

map("x", "<leader>aa", function()
	require("codecompanion").add()
end)

-- Nvim Tree
map("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "toggle nvim-tree" })

-- Dropbar
map("n", "<Leader>;", function()
	require("dropbar.api").pick()
end, { desc = "Pick symbols in winbar" })

map("n", "[;", function()
	require("dropbar.api").goto_context_start()
end, { desc = "Go to start of current context" })

map("n", "];", function()
	require("dropbar.api").select_next_context()
end, { desc = "Select next context" })

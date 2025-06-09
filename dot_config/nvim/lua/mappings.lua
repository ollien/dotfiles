require("nvchad.mappings")

local grug_find = require("config_util.grug_far")

local map = vim.keymap.set

local function find_files()
	require("telescope.builtin").find_files({ hidden = true })
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>o", find_files, { desc = "telescope find files" })
map("n", "<leader>ff", find_files, { desc = "telescope find files" })
map("n", "<leader>fk", require("telescope.builtin").keymaps, { noremap = true, desc = "telescope find keymaps" })
map("n", "<leader>fc", require("telescope.builtin").commands, { noremap = true, desc = "telescope find commands" })
map("n", "<leader>fp", "<cmd>NeovimProjectDiscover<cr>", { noremap = true, desc = "telescope find projects" })
map("n", "<leader>fr", require("telescope.builtin").resume, { noremap = true, desc = "telescope resume" })
map("n", "<leader>fw", grug_find.find_or_open_grug_far, { desc = "find and replace" })
map("n", "<leader>ae", require("avante.api").edit, { desc = "avante edit" })
map("n", "<leader>ac", function()
	require("avante.api").ask({ ask = false, new_chat = true })
end, { desc = "avante chat resume" })
map("n", "<leader>ar", function()
	require("avante.api").ask({ ask = false })
end, { desc = "avante chat resume" })

require("nvchad.mappings")

local grug_far = require("config_util.grug_far")

local map = vim.keymap.set

local function find_files()
	require("telescope.builtin").find_files({ hidden = true })
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("x", "<leader>p", '"_dP')
map({ "x", "n" }, "<leader>d", '"_d', { noremap = true, desc = "delete to blackhole" })
map({ "x", "n" }, "<leader>c", '"_c', { noremap = true, desc = "change to blackhole" })
map("n", "<leader>o", find_files, { noremap = true, desc = "telescope find files" })
map("n", "<leader>ff", find_files, { noremap = true, desc = "telescope find files" })
map("n", "<leader>fk", require("telescope.builtin").keymaps, { noremap = true, desc = "telescope find keymaps" })
map("n", "<leader>fc", require("telescope.builtin").commands, { noremap = true, desc = "telescope find commands" })
map("n", "<leader>fp", "<cmd>NeovimProjectDiscover<cr>", { noremap = true, desc = "telescope find projects" })
map("n", "<leader>fb", require("telescope.builtin").buffers, { noremap = true, desc = "telescope find buffers" })
map("n", "<leader>fr", require("telescope.builtin").resume, { noremap = true, desc = "telescope resume" })
map("n", "<leader>fw", grug_far.find_or_open_grug_far, { noremap = true, desc = "find and replace" })
map("n", "<leader>ac", require("codecompanion").chat)
map("n", "<leader>ar", require("codecompanion").last_chat)
map("n", "<leader>ae", "<cmd>CodeCompanion<cr>")
map("x", "<leader>ae", "<cmd>'<,'>CodeCompanion<cr>")
map("x", "<leader>aa", require("codecompanion").add)
map("n", "<leader>h", "<cmd>noh<cr>", { desc = "clear highlighting" })
-- Remove vertical terminal mapping since we just overrode the horizontal one
vim.keymap.del("n", "<leader>v", {})

require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", { desc = "telescope find files" })
map("n", "<leader>fk", require("telescope.builtin").keymaps, { noremap = true, desc = "telescope find keymaps" })
map("n", "<leader>fr", require("telescope.builtin").resume, { noremap = true, desc = "telescope resume" })
map("n", "<leader>fw", require("grug-far").open)

vim.g.mapleader = " "
local map = vim.keymap.set
local builtin = require('telescope.builtin')

map("n", "<leader>fv", vim.cmd.Ex)
map("n", "<F1>", "<nop>")
map("i", "<F1>", "<nop>")

map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})

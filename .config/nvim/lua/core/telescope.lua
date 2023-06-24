local ts = require('telescope')
local bt = require('telescope.builtin')
local map = vim.keymap.set

ts.setup({
    defaults = {
        hidden = true,
        borderchars = {
            prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
            results = { ' ' },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        }
    }
})

map('n', '<leader>ff', bt.find_files, {})
map('n', '<leader>fg', bt.live_grep, {})
map('n', '<leader>fb', bt.buffers, {})
map('n', '<leader>fh', bt.help_tags, {})

local bt = require('telescope.builtin')

require('telescope').setup({
    pickers = {
        find_files = {
            hidden = true
        }
    },
    defaults = {
        hidden = true,
        borderchars = {
            prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
            results = { ' ' },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        }
    }
})

vim.keymap.set('n', '<leader>ff', bt.find_files, {})
vim.keymap.set('n', '<leader>fg', bt.live_grep, {})
vim.keymap.set('n', '<leader>fb', bt.buffers, {})
vim.keymap.set('n', '<leader>fh', bt.help_tags, {})
vim.keymap.set('n', '<leader>fr', bt.oldfiles, {})

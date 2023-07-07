local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

require('harpoon').setup({
    menu = {
        number = 'false',
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
    }
})

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>r", mark.rm_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<M-1>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<M-2>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<M-3>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<M-4>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<M-5>", function() ui.nav_file(5) end)

vim.cmd('autocmd Filetype harpoon setlocal nonumber cursorline')

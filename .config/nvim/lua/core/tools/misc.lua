vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
        update_root = true,
    },
})

require('gitsigns').setup()

require('toggleterm').setup({
    direction = 'vertical',
    size = 50,
    start_in_insert = false,
})


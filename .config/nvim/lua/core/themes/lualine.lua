local function harpoon()
    local idx = require('harpoon.mark').get_current_index()
    if idx == nil then
        return ''
    end

    local name = vim.fn.expand('%:t')
    return string.format( '⇌  %d ┃ %s', idx, name)
end

require("lualine").setup {
    options = {
        theme = 'material',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = { 'tabs' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { harpoon }
    }
}

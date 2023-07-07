local options = {
    nu = true,
    rnu = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    wrap = false,

    swapfile = false,

    hlsearch = false,
    incsearch = true,

    termguicolors = true,
    scrolloff = 8,
    signcolumn = 'yes',
    colorcolumn = '80',
    updatetime = 100
}

for k, v in pairs(options) do
    vim.o[k] = v
end

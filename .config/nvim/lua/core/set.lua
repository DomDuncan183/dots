local options = {
    nu = true,
    rnu = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    wrap = false,
    swapfile = false,
    termguicolors = true,
    scrolloff = 8,
    --signcolumn = 'yes'
    --colorcolumn = '80'
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

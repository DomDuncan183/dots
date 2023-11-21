local options = {
    number = true,
    relativenumber = true,

    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    wrap = false,
    swapfile = false,

    scrolloff = 10,
    updatetime = 100,
    --splitright = true
    --signcolumn = 'yes',
    --colorcolumn = '80',
}

local global = {
    mapleader = ' ',
    netrw_banner = 0,
    netrw_altv = 1,
}

for k, v in pairs(options) do
    vim.o[k] = v
end

for k, v in pairs(global) do
    vim.g[k] = v
end

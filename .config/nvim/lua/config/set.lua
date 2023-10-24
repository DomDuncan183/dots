local options = {
    nu = true,
    rnu = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    wrap = false,

    swapfile = false,

    --hlsearch = false,
    --incsearch = true,
    --nohls

    --termguicolors = true,
    scrolloff = 8,
    --signcolumn = 'yes',
    --colorcolumn = '80',
    updatetime = 100
    --splitright = true
}

for k, v in pairs(options) do
    vim.o[k] = v
end

vim.g.netrw_banner = 0
vim.g.netrw_altv = 1

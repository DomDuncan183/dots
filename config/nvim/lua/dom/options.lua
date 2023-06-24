local options = {
    nu = true,
    relativenumber = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

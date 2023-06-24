require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

require('lspconfig').clangd.setup({})
require('lspconfig').pyright.setup({})

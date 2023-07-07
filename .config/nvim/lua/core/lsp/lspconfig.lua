local lc = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'clangd',
        'pyright'
    }
})

lc.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = {'vim'}
            }
        }
    }
})

lc.clangd.setup({})
lc.pyright.setup({})

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c',
        'cpp',
        'rust',
        'python',
        'lua',
        'yaml',
        'bash',
        'vim',
        'vimdoc',
        'query'
    },
    sync_install = false,
    auto_install = true,
    highlight = {enable = true}
})

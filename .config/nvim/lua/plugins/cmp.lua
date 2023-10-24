return {
    --{'L3MON4D3/LuaSnip', lazy = true},
    --{'saadparwaiz1/cmp_luasnip', lazy = true},
    --{'hrsh7th/cmp-buffer', lazy = true},
    --{'hrsh7th/cmp-path', lazy = true},
    --{'hrsh7th/cmp-cmdline', lazy = true},
    --{'hrsh7th/cmp-nvim-lsp', lazy = true},
    'hrsh7th/nvim-cmp',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
    },
    event = 'BufRead',

    config = function()
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'buffer' },
            })
        })

        --cmp.setup.filetype('gitcommit', {
            --    sources = cmp.config.sources({
                --        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                --    }, {
                    --        { name = 'buffer' },
                    --    })
                    --})

                    cmp.setup.cmdline({ '/', '?' }, {
                        mapping = cmp.mapping.preset.cmdline(),
                        sources = {
                            { name = 'buffer' }
                        }
                    })

                    cmp.setup.cmdline(':', {
                        mapping = cmp.mapping.preset.cmdline(),
                        sources = cmp.config.sources({
                            { name = 'path' }
                        }, {
                            { name = 'cmdline' }
                        })
                    })

                end
            }

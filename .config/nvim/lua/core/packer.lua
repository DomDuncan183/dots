return require('packer').startup({
    function(use)
        use('wbthomason/packer.nvim')

        -- lsp
        use('neovim/nvim-lspconfig')
        use({'williamboman/mason.nvim', run = ':MasonUpdate'})
        use({'williamboman/mason-lspconfig.nvim'})
        use('hrsh7th/nvim-cmp')
        use('hrsh7th/cmp-nvim-lsp')
        use('hrsh7th/cmp-buffer' )
        use('hrsh7th/cmp-path')
        use('hrsh7th/cmp-cmdline')
        use('saadparwaiz1/cmp_luasnip')
        use({'L3MON4D3/LuaSnip', tag = 'v1.*', run = 'make install_jsregexp'})
        use('rafamadriz/friendly-snippets')
        use({'onsails/lspkind.nvim'})
        use({'nvimdev/lspsaga.nvim', event = 'LspAttach'})

        -- tool
        use('nvim-tree/nvim-tree.lua')
        use('nvim-tree/nvim-web-devicons')
        use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
        use({'nvim-telescope/telescope.nvim', tag = '0.1.1'})
        use('nvim-lua/plenary.nvim')
        use('theprimeagen/harpoon')
        use('mbbill/undotree')
        use({'windwp/nvim-autopairs' })
        use({'akinsho/toggleterm.nvim', tag = '*' })
        use('lewis6991/gitsigns.nvim')
        use('tpope/vim-fugitive')

        -- theme
        use('nvimdev/dashboard-nvim')
        use('nvim-lualine/lualine.nvim')
        use('rebelot/kanagawa.nvim')
        use('folke/tokyonight.nvim')
        use('catppuccin/nvim')
    end,

    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})

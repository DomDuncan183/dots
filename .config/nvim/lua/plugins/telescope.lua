return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,

    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = 'Live Grep'  },
        { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = 'Buffers'    },
        { '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = 'Help Tags'  },
        { '<leader>fr', '<cmd>Telescope oldfiles<cr>',   desc = 'Old Files'  },
    }
}

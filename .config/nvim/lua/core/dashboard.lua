require('dashboard').setup({
    theme = 'doom',
    config = {
        header = {
            '                                                       ',
            '                                                       ',
            '                                                       ',
            '                                                       ',
            '                                                       ',
            '                                                       ',
            '                                                       ',
            ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            '                                                       ',
            '                                                       ',
            '                                                       ',
            '                                                       ',
        },
        center = {
            {
                icon = '  ',
                desc = 'New file                                ',
                action = 'enew',
                key = 'e',
            },
            {
                icon = '󱋡  ',
                desc = 'Recent Files                            ',
                action = 'Telescope oldfiles',
                key = 'l',
            },
            {
                icon = '󰈞  ',
                desc = 'Find  File                              ',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                icon = '󱎸  ',
                desc = 'Find Word                               ',
                action = 'Telescope live_grep',
                key = 'w',
            },
            {
                icon = '󰥨  ',
                desc = 'File Browser                            ',
                action = 'Ex',
                key = 'b',
            },
            {
                icon = '󰗼  ',
                desc = 'Quit Nvim                               ',
                action = 'qa',
                key = 'q',
            },
        },
        footer = {
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
        }
    }
})

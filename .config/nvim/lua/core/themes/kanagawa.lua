require('kanagawa').setup({
    colors = {
        theme = {
            all = {
                ui = {
                    bg = 'none',
                    bg_gutter = 'none',
                }
            }
        }
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            LineNr = { fg = colors.palette.boatYellow1 },

            TelescopeBorder = { bg = theme.ui.bg_m1 },
            TelescopeNormal = { bg = theme.ui.bg_m1 },

            HarpoonWindow = { bg = theme.ui.bg_m1 },
            HarpoonBorder = { bg = theme.ui.bg_m1 },

            --[[
            TelescopeTitle = { fg = theme.ui.fg, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.special,  bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.special, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { fg = theme.ui.special,  bg = theme.ui.bg_dim },
            --]]

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            DashboardHeader = { fg = theme.ui.fg }
        }
    end,
})

vim.cmd.colorscheme 'kanagawa'

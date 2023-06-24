require 'catppuccin'.setup({
    flavour = 'mocha',
    transparent_background = true,
    custom_highlights = function(colors)
        return {
            telescopeNormal = { bg = colors.mantle },
            telescopeBorder = { bg = colors.mantle }
        }
    end
})

vim.cmd.colorscheme 'catppuccin'

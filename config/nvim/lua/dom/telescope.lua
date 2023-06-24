require('telescope').setup{
    defaults = {
        hidden = true,
        borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
    }
}

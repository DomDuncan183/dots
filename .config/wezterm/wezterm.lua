local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.enable_wayland = false
config.font = wezterm.font("Iosevka NF")
config.font_size = 12

config.hide_mouse_cursor_when_typing = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = "Tokyo Night"
config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
}
config.disable_default_key_bindings = true
config.keys = {
    { key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
}

return config

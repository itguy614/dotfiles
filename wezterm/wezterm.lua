local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 10

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- Window
config.window_padding = {
	left = 10,
	right = 20,
	top = 10,
	bottom = 10,
}
config.window_decorations = "TITLE | RESIZE"
config.initial_cols = 132
config.initial_rows = 43

-- Scrollbar
config.enable_scroll_bar = true
config.scrollback_lines = 10000

-- Tab bar (hidden - using tmux)
config.enable_tab_bar = false

-- Bell
config.audible_bell = "Disabled"

-- Use X11 instead of Wayland
config.enable_wayland = false

-- Color scheme
config.color_scheme = "Google Dark (Gogh)"

return config

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

-- Color scheme: Nord Light Brighter, matching ghostty/config
config.colors = {
  foreground = "#24292e",
  background = "#ffffff",
  cursor_bg = "#044289",
  cursor_fg = "#ffffff",
  cursor_border = "#044289",
  selection_fg = "#24292e",
  selection_bg = "#c2d9f5",
  ansi = {
    "#24292e", -- black
    "#a74047", -- red
    "#50750e", -- green
    "#e36209", -- yellow
    "#1155a3", -- blue
    "#6f42c1", -- magenta
    "#2f6f9f", -- cyan
    "#d6d6d6", -- white
  },
  brights = {
    "#8995a0", -- bright black
    "#d73a49", -- bright red
    "#22863a", -- bright green
    "#cd9731", -- bright yellow
    "#005cc5", -- bright blue
    "#7653c1", -- bright magenta
    "#4f9fcf", -- bright cyan
    "#ebebeb", -- bright white
  },
}

return config

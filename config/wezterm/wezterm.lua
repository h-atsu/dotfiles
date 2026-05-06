local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0

-- Color scheme
config.color_scheme = "Tokyo Night"

-- Window
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true

-- Keybinds
config.keys = {
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
}

return config

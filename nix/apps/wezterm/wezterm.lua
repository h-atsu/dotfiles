local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.0
config.use_ime = true

-- Color scheme
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.show_tabs_in_tab_bar = true
config.window_decorations = "RESIZE"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#ffffff"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#ffffff"
  end

  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)


return config

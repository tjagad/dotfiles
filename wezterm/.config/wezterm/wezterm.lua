local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { '/bin/bash' }

config.font_size = 12
config.font = wezterm.font('MonacoLigaturized Nerd Font Mono')
config.enable_tab_bar = false

config.colors = {
  background = "#000000"
}
config.color_scheme = "Catppuccin Mocha"

return config

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { '/bin/bash' }

config.freetype_load_flags = 'NO_HINTING'

config.font_size = 12
-- config.font = wezterm.font('RecMonoLinear Nerd Font Mono', { weight = 'Light', italic = true })
config.font = wezterm.font('FiraCode Nerd Font Mono Ret')
config.font = wezterm.font('CodeNewRoman Nerd Font Mono')
config.font = wezterm.font('Maple Mono NF')
config.font = wezterm.font('MonacoLigaturized Nerd Font Mono')
config.font = wezterm.font('RecMonoCasual Nerd Font Mono')
config.font = wezterm.font('RecMonoLinear Nerd Font Mono')
config.font = wezterm.font('RecMonoSmCasual Nerd Font Mono')
config.font = wezterm.font('DroidSansM Nerd Font Mono')
config.font = wezterm.font('VictorMono Nerd Font Mono', { weight = 'DemiBold' })
config.font = wezterm.font('JuliaMono')
config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'DemiBold', stretch = 'Normal' })
config.font = wezterm.font_with_fallback {
  { family = 'Maple Mono', weight = 'DemiBold', stretch = 'Normal' },
  { family = 'Symbols Nerd Font Mono', weight = 'Regular', stretch = 'Normal' }
}
config.enable_tab_bar = false

config.colors = {
  background = "#000000"
}
config.color_scheme = "Catppuccin Mocha"

return config

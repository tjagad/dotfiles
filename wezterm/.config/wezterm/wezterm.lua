local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { '/bin/bash' }

config.freetype_load_flags = 'NO_HINTING'
config.freetype_render_target = 'HorizontalLcd'

-- Helper to get your manual font size from the file
local function get_base_font_size()
    local ok, size = pcall(require, 'font_size')
    return ok and size or 14
end

config.font_size = get_base_font_size()

-- Using 'window-resized' to catch the move between monitors immediately
wezterm.on('window-resized', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local base_size = get_base_font_size()
    local current_dpi = window:get_dimensions().dpi

    local new_size
    if current_dpi > 120 then
        -- Default for Asus Laptop 2.8K OLED
        new_size = base_size
    else
        -- Scaled down for LG 1080p Ultrawide
        new_size = base_size - 1
    end

    -- Only apply if the size actually changed to avoid flickering
    if overrides.font_size ~= new_size then
        overrides.font_size = new_size
        window:set_config_overrides(overrides)
    end
end)

-- config.font = wezterm.font('RecMonoLinear Nerd Font Mono', { weight = 'Light', italic = true })
config.font = wezterm.font('FiraCode Nerd Font Mono Ret')
config.font = wezterm.font('CodeNewRoman Nerd Font Mono')
config.font = wezterm.font('MonacoLigaturized Nerd Font Mono')
config.font = wezterm.font('RecMonoCasual Nerd Font Mono')
config.font = wezterm.font('RecMonoLinear Nerd Font Mono')
config.font = wezterm.font('RecMonoSmCasual Nerd Font Mono')
config.font = wezterm.font('DroidSansM Nerd Font Mono')
config.font = wezterm.font('VictorMono Nerd Font Mono', { weight = 'DemiBold' })
config.font = wezterm.font('JuliaMono')
config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'DemiBold', stretch = 'Normal' })
config.font = wezterm.font('Maple Mono NFMono', { weight = 'Medium', stretch = 'Normal' })
-- config.font = wezterm.font_with_fallback {
--   { family = 'Maple Mono NFMono', weight = 'Medium', stretch = 'Normal' },
  -- { family = 'MonacoLigaturized Nerd Font Mono', weight = 'Regular' },
  -- { family = 'CodeNewRoman Nerd Font Mono', weight='Regular', stretch = 'Normal' },
  -- { family = 'RecMonoCasual Nerd Font Mono', weight='Regular', stretch = 'Normal' },
  -- { family = 'RecMonoSmCasual Nerd Font Mono', weight='Regular', stretch = 'Normal' },
  -- { family = 'RecMonoLinear Nerd Font Mono', weight='Regular', stretch = 'Normal' },
  -- { family = 'VictorMono Nerd Font Mono', weight='DemiBold', stretch = 'Normal' },
  -- { family = 'JetBrainsMono Nerd Font Mono', weight='DemiBold', stretch = 'Normal' },
  -- { family = 'Symbols Nerd Font Mono', weight = 'Regular', stretch = 'Normal' }
-- }
config.enable_tab_bar = false

config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 1.0

return config

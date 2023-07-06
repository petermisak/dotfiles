local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.color_scheme = 'AtomOneLight'
config.color_scheme = 'Piatto Light'
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' })
config.font_size = 13
config.line_height = 1.2
config.initial_cols = 135
config.initial_rows = 40

config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false

-- Config for light mode
config.window_frame = {
  inactive_titlebar_fg = '#ccc',
  inactive_titlebar_bg = '#eaeaea',
  active_titlebar_bg = '#eaeaea',
  active_titlebar_fg = '#666',
  active_titlebar_border_bottom = '#eaeaea',
  inactive_titlebar_border_bottom = 'white',
  button_fg = '#666',
  button_bg = '#eaeaea',
  button_hover_fg = '#333',
  button_hover_bg = '#ddd'
}

config.colors = {
  tab_bar = {
    background = '#eee',

    active_tab = {
      bg_color = '#ddd',
      fg_color = '#666'
    },

    inactive_tab = {
      bg_color = '#eee',
      fg_color = '#bbb'
    },
    inactive_tab_hover = {
      bg_color = '#bbb',
      fg_color = '#555'
    },

    new_tab = {
      bg_color = '#efefef',
      fg_color = '#333'
    },
    new_tab_hover = {
      bg_color = '#bbb',
      fg_color = '#555'
    }
  }
}

return config

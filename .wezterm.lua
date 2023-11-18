local wezterm = require 'wezterm'

---cycle through builtin dark schemes in dark mode, 
---and through light schemes in light mode
local function themeCycler(window, _)
  local allSchemes = wezterm.color.get_builtin_schemes()
  local currentMode = wezterm.gui.get_appearance()
  local currentScheme = window:effective_config().color_scheme
  local darkSchemes = {}
  local lightSchemes = {}

  for name, scheme in pairs(allSchemes) do
    local bg = wezterm.color.parse(scheme.background) -- parse into a color object
    ---@diagnostic disable-next-line: unused-local
    local h, s, l, a = bg:hsla() -- and extract HSLA information
    if l < 0.4 then
      table.insert(darkSchemes, name)
    else
      table.insert(lightSchemes, name)
    end
  end
  local schemesToSearch = currentMode:find("Dark") and darkSchemes or lightSchemes

  for i = 1, #schemesToSearch, 1 do
    if schemesToSearch[i] == currentScheme then
      local overrides = window:get_config_overrides() or {}
      overrides.color_scheme = schemesToSearch[i+1]
      wezterm.log_info("Switched to: " .. schemesToSearch[i+1])
      window:set_config_overrides(overrides)
      return
    end
  end
end

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.color_scheme = 'AtomOneLight'
-- config.color_scheme = 'Piatto Light'
config.color_scheme = 'One Light (base16)'
-- config.color_scheme = 'Tomorrow'
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

config.keys = {
  -- Theme Cycler
  { key = "t", mods = "ALT", action = wezterm.action_callback(themeCycler) },

  -- Look up Scheme you switched to
  { key = "Escape", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}

return config

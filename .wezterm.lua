local wezterm = require("wezterm")

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
			overrides.color_scheme = schemesToSearch[i + 1]
			wezterm.log_info("Switched to: " .. schemesToSearch[i + 1])
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

-- Autodetect OS theme changes
local appearance = wezterm.gui.get_appearance()
local scheme = "light"
-- local light_scheme = "One Light (base16)"
-- local light_scheme = "Github (base16)"
-- local light_scheme = "zenbones"
local light_scheme = "Rosé Pine Dawn (Gogh)"
-- local light_scheme = "dayfox"
-- local light_scheme = "dawnfox"
-- local light_scheme = "Catppuccin Latte"
-- local light_scheme = "Piatto Light"
-- local light_scheme = "Tokyo Night Day"
-- local dark_scheme = "Catppuccin Macchiato"
-- local dark_scheme = "Catppuccin Mocha"
-- local dark_scheme = "Catppuccin Frappe"
-- local dark_scheme = "Tokyo Night Storm"
-- local dark_scheme = "Tokyo Night Moon"
local dark_scheme = "Rosé Pine Moon (Gogh)"
-- local dark_scheme = "Rosé Pine (Gogh)"
-- local dark_scheme = "nightfox"
-- local dark_scheme = "duskfox"

if appearance:find("Dark") then
	scheme = dark_scheme
else
	scheme = light_scheme
end

wezterm.on("toggle-dark-mode", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local flavour = "dark"
	if overrides.color_scheme == light_scheme then
		overrides.color_scheme = dark_scheme
	else
		overrides.color_scheme = light_scheme
		flavour = "light"
	end
	window:set_config_overrides(overrides)
	local success, stdout, stderr = wezterm.run_child_process({
		"/opt/homebrew/bin/fish",
		"-c",
		"change_background " .. flavour,
	})
	wezterm.log_info("result: ", success, ", stdout: ", stdout, ", stderr: ", stderr)
end)

config.set_environment_variables = {
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

config.color_scheme = scheme
config.colors = colors
config.window_frame = window_frame
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" }) -- weight e.g.: Regular, Medium, DemiBold
config.font_size = 14
config.line_height = 1.2
config.initial_cols = 135
config.initial_rows = 40

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 10
config.window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW"

local act = wezterm.action

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "j", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "h", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },

	{ key = "h", mods = "CMD|SHIFT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "l", mods = "CMD|SHIFT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "k", mods = "CMD|SHIFT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "j", mods = "CMD|SHIFT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- Splitting
	{ mods = "LEADER", key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "+", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Theme Cycler
	{ key = "t", mods = "ALT", action = wezterm.action_callback(themeCycler) },

	-- Look up Scheme you switched to
	{ key = "Escape", mods = "CTRL", action = act.ShowDebugOverlay },

	-- Switch color schemes via keyboard shortcut
	{ key = "m", mods = "CMD|SHIFT", action = wezterm.action({ EmitEvent = "toggle-dark-mode" }) },
}

return config

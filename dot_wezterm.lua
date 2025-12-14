local wezterm = require("wezterm")

local config = wezterm.config_builder()








config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", '-NoLogo' }
-- config.color_scheme = "Batman"
config.color_scheme = "Catppuccin Mocha"








-- my coolnight colorscheme:
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

config.window_background_opacity = 1
-- config.macos_window_background_blur = 10

config.font = wezterm.font_with_fallback {

	"Fira Code",
	"Noto Color Emoji",
	"Segoe UI Emoji",
	"JetBrains Mono",
  "DengXian"

}
config.font_size = 10

config.enable_tab_bar = false

config.window_decorations = "RESIZE"


-- Load the modal plugin
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

-- Apply modal plugin to config
modal.apply_to_config(config)
modal.set_default_keys(config)

-- Optional: update right status when mode changes
-- wezterm.on("modal.enter", function(name, window, pane)
--   modal.set_right_status(window, name)
--   modal.set_window_title(pane, name)
-- end)

-- wezterm.on("modal.exit", function(name, window, pane)
--   window:set_right_status("NOT IN A MODE")
--   modal.reset_window_title(pane)
-- end)

-- wezterm.on('format-window-title', function()
-- return 'wezterm'
-- end)






return config

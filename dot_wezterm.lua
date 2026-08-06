local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", '-NoLogo' }
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
config.macos_window_background_blur = 10

config.font = wezterm.font_with_fallback({

        "Fira Code",
        "FiraCode Nerd Font",
        "Noto Color Emoji",
        "Segoe UI Emoji",
        "JetBrains Mono",
        "DengXian",
})
config.font_size = 12

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

local log
wezterm.on("restart-current-tab", function(window, pane)
        local mux_window = window:mux_window()
        local tabs = mux_window:tabs()
        -- wezterm.log_info("restart-current-tab triggered")
        -- wezterm.log_info("tab count = ", #tabs)
        window:toast_notification("WezTerm Debug", "Tabs: " .. tostring(#tabs), nil, 100)

        -- If this is the only tab, spawn first so the window doesn't exit
        if #tabs == 1 then
                window:toast_notification("in if condition", "Tabs: " .. tostring(#tabs), nil, 100)

                -- Give Windows time to start the new GUI
                -- wezterm.time.call_after(0.4, function()
                -- 	window:perform_action(
                -- 		act.CloseCurrentTab { confirm = false },
                -- 		pane
                -- 	)
                -- end)
                -- window:perform_action(
                -- 	act.SpawnCommandInNewTab {
                -- 		args = { "pwsh.exe", "-NoLogo" },
                -- 	},
                -- 	act.CloseCurrentTab { confirm = false },
                -- 	pane
                -- )
                window:perform_action(
                        act.Multiple({
                                -- act.SpawnCommandInNewTab {
                                -- 	args = { "pwsh.exe", "-NoLogo" },
                                -- },
                                act.CloseCurrentTab({ confirm = false }),
                                wezterm.run_child_process({ "wezterm.exe" }),
                        }),
                        pane
                )
        else
                -- If other tabs exist, replace by spawning + closing
                window:perform_action(
                        act.Multiple({
                                act.SpawnCommandInNewTab({
                                        args = { "pwsh.exe", "-NoLogo" },
                                }),
                                act.CloseCurrentTab({ confirm = false }),
                        }),
                        pane
                )
        end
end)

config.keys = {
        {
                key = "r",
                mods = "CTRL|SHIFT",
                action = act.EmitEvent("restart-current-tab"),
        },
}

return config

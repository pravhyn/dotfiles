-- debug.disable_logs = false
-- debug.gl_debugging = false

-- Monitor
-- exec_once = {
--         "hyprpaper",
--         "nm-applet",
--         "waybar",
-- }

hl.on("hyprland.start", function()
        hl.exec_cmd("hyprpaper")
        hl.exec_cmd("nm-applet")
        hl.exec_cmd("swaync")
        -- hl.exec_cmd("waybar")
        -- hl.exec_cmd("hintsd")
end)
hl.monitor({
        output = "",
        mode = "preferred",
        position = "auto",
        scale = "auto",
})

hl.config({
        input = {
                left_handed = true,
        },
})

-- Monitor alignment
hl.monitor({
        output = "eDP-1",
        mode = "1920x1080",
        position = "1920x0",
        scale = 1.1,
})
hl.monitor({
        output = "HDMI-A-1",
        mode = "1920x1080",
        position = "0x0",
        scale = 1,
})

-- hl.bind("ALT + Space", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind("ALT + Space", hl.dsp.exec_cmd("hyprlauncher"))
-- Programs
local terminal = "kitty"
local launcher = "wofi --show drun"

-- Print: Full screen -> save + clipboard
-- hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind(
        "Print",
        hl.dsp.exec_cmd(
                'grim - | /home/praveen/.cargo/bin/satty -f - --copy-command wl-copy -o "$HOME/Pictures/Screenshots/%Y%m%d_%H%M%S.png"'
        )
)
-- Shift+Print: Region -> save + clipboard
-- hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind(
        "SUPER + Print",
        hl.dsp.exec_cmd('grim - | satty -f - --copy-command wl-copy -o "~/Pictures/Screenshots/%Y%m%d_%H%M%S.png"')
)

hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprpicker -a"))
-- Basic settings
hl.config({
        general = {
                gaps_in = 0,
                gaps_out = 0,
                border_size = 0,
                layout = "dwindle",
        },

        input = {
                kb_layout = "us",
                follow_mouse = 1,
        },

        decoration = {
                rounding = 8,
        },

        animations = {
                enabled = true,
        },

        dwindle = {
                preserve_split = true,
        },
})

local mod = "SUPER"
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("hints"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("hints --mode scroll"))
-------------------------------------------------
-- Launching
-------------------------------------------------

hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + D", hl.dsp.exec_cmd(launcher))

-------------------------------------------------
-- Window management
-------------------------------------------------

hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(
        mod .. " + F",
        hl.dsp.window.fullscreen({
                mode = "maximized",
        })
)
hl.bind(mod .. " + V", hl.dsp.window.float())

-------------------------------------------------
-- Focus (Vim)
-------------------------------------------------

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

-------------------------------------------------
-- Move windows
-------------------------------------------------

hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-------------------------------------------------
-- Resize windows
-------------------------------------------------

hl.bind(mod .. " + CTRL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
-------------------------------------------------
-- Workspaces
-------------------------------------------------

for i = 1, 9 do
        hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
        hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- local external_disabled = false
--
-- hl.bind(mod, "L", function()
--         external_disabled = not external_disabled
--
--         hl.monitor({
--                 output = "HDMI-A-1",
--                 disabled = external_disabled,
--         })
-- end)

-------------------------------------------------
-- Mouse
-------------------------------------------------

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.bind(mod .. " + P", hl.dsp.exec_cmd("pkill waybar || waybar &"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("pkill quickshell || quickshell &"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

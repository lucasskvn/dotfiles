---@meta
-------------------------------------------------------------------------------
-- OXWM Configuration File
-------------------------------------------------------------------------------
-- This is the default configuration for OXWM, a dynamic window manager.
-- Edit this file and reload with Mod+Shift+R (no compilation needed)
--
-- For more information about configuring OXWM, see the documentation.
-- The Lua Language Server provides autocomplete and type checking.
-------------------------------------------------------------------------------

---Load type definitions for LSP
---@module 'oxwm'

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
-- Define your variables here for easy customization throughout the config.
-- This makes it simple to change keybindings, colors, and settings in one place.

-- Modifier key: "Mod4" is the Super/Windows key, "Mod1" is Alt
local modkey = "Mod4"

-- Terminal emulator command (defaults to alacritty)
local terminal = "/usr/local/bin/st"

-- Color palette - customize these to match your theme
-- Alternatively you can import other files in here, such as 
-- local colors = require("colors.lua") and make colors.lua a file
-- in the ~/.config/oxwm directory
local colors = {
    fg = "#bbbbbb",
    red = "#f7768e",
    bg = "#1a1b26",
    cyan = "#0db9d7",
    green = "#9ece6a",
    lavender = "#a9b1d6",
    light_blue = "#7aa2f7",
    grey = "#bbbbbb",
    blue = "#6dade3",
    purple = "#ad8ee6",
}

-- Workspace tags - can be numbers, names, or icons (requires a Nerd Font)
local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- local tags = { "", "󰊯", "", "", "󰙯", "󱇤", "", "󱘶", "󰧮" } -- Example of nerd font icon tags

-- Font for the status bar (use "fc-list" to see available fonts)
local bar_font = "monospace:style=Bold:size=10"

-- Define your blocks
-- Similar to widgets in qtile, or dwmblocks
local blocks = {
    oxwm.bar.block.ram({
        format = "Ram: {used}/{total} GB",
        interval = 5,
        color = colors.light_blue,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.lavender,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "{}",
        command = "uname -r",
        interval = 999999999,
        color = colors.red,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.lavender,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "C {}",
        command = "awk '{printf \"%dC\", $1/1000}' /sys/class/hwmon/hwmon5/temp1_input",
        interval = 10,
        color = colors.blue,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "U {}",
        command = "top -bn1 | grep \"Cpu(s)\" | awk '{print $2+$4 \"%\"}'",
        interval = 10,
        color = colors.green,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.lavender,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "V {}",
        command = "amixer -D pulse sget Master 2>/dev/null | grep -oE '[0-9]+%' | head -1",
        interval = 2,
        color = colors.cyan,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "{}",
        command = "iwgetid -r 2>/dev/null || echo offline",
        interval = 10,
        color = colors.light_blue,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │ ",
        interval = 999999999,
        color = colors.lavender,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "{}",
        command = "curl -s 'wttr.in/Lyon?format=%c%t' 2>/dev/null || echo N/A",
        interval = 600,
        color = colors.purple,
        underline = false,
    }),
    oxwm.bar.block.shell({
        format = "↑ {}",
        command = "checkupdates 2>/dev/null | wc -l",
        interval = 3600,
        color = colors.red,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.lavender,
        underline = false,
    }),
    oxwm.bar.block.datetime({
        format = "{}",
        date_format = "%a, %b %d - %-I:%M:%S %P",
        interval = 1,
        color = colors.cyan,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.lavender,
        underline = false,
    }),
    oxwm.bar.block.battery({
         format = "Bat: {}%",
         charging = "⚡ Bat: {}%",
         discharging = "Bat: {}%",
         full = "✓ Bat: {}%",
         interval = 30,
         color = colors.green,
         underline = false,
         battery_name = "BAT1",
    }),
};

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------
oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- This is for Mod + mouse binds, such as drag/resize
oxwm.set_tags(tags)

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
-- Set custom symbols for layouts (displayed in the status bar)
-- Available layouts: "tiling", "normie" (floating), "grid", "monocle", "tabbed"
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
-- Border configuration

-- Width in pixels
oxwm.border.set_width(2)
-- Color of focused window border
oxwm.border.set_focused_color(colors.red)
-- Color of unfocused window borders
oxwm.border.set_unfocused_color(colors.grey)

-- Smart Enabled = No border if 1 window
oxwm.gaps.set_smart(true)
-- Inner gaps (horizontal, vertical) in pixels
oxwm.gaps.set_inner(5, 5)
-- Outer gaps (horizontal, vertical) in pixels
oxwm.gaps.set_outer(5, 5)

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
-- Rules allow you to automatically configure windows based on their properties
-- You can match windows by class, instance, title, or role
-- Available properties: floating, tag, fullscreen, etc.
--
-- Common use cases:
-- - Force floating for certain applications (dialogs, utilities)
-- - Send specific applications to specific workspaces
-- - Configure window behavior based on title or class

-- Examples (uncomment to use):
oxwm.rule.add({ instance = "gimp", floating = true })                             
-- oxwm.rule.add({ class = "Alacritty", tag = 9, focus = true })                             
-- oxwm.rule.add({ class = "firefox", title = "Library", floating = true })  
-- oxwm.rule.add({ class = "firefox", tag = 2 })  
-- oxwm.rule.add({ instance = "mpv", floating = true })                      

-- To find window properties, use xprop and click on the window
-- WM_CLASS(STRING) shows both instance and class (instance, class)

-------------------------------------------------------------------------------
-- Status Bar Configuration
-------------------------------------------------------------------------------
-- Font configuration
oxwm.bar.set_font(bar_font)

-- Set your blocks here (defined above)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes (for workspace tag display)
-- Parameters: foreground, background, border

-- Unoccupied tags
oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "#444444")
-- Occupied tags
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)
-- Currently selected tag
oxwm.bar.set_scheme_selected(colors.red, colors.bg, colors.purple)
-- Urgent tags (windows requesting attention)
oxwm.bar.set_scheme_urgent(colors.red, colors.bg, colors.red)

-- Hide tags that have no windows and are not selected
-- oxwm.bar.set_hide_vacant_tags(true)

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------
-- Keybindings are defined using oxwm.key.bind(modifiers, key, action)
-- Modifiers: {"Mod4"}, {"Mod1"}, {"Shift"}, {"Control"}, or combinations like {"Mod4", "Shift"}
-- Keys: Use uppercase for letters (e.g., "Return", "H", "J", "K", "L")
-- Actions: Functions that return actions (e.g., oxwm.spawn(), oxwm.client.kill())
--
-- A list of available keysyms can be found in the X11 keysym definitions.
-- Common keys: Return, Space, Tab, Escape, Backspace, Delete, Left, Right, Up, Down

-- Basic window management

oxwm.key.bind({ modkey }, "Return", oxwm.spawn_terminal())
oxwm.key.bind({ modkey, "Shift" }, "M", oxwm.spawn({ "sh", "-c", "betterlockscreen -l dim"}))

-- Launch Dmenu
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" }))
-- Screenshot with flameshot
oxwm.key.bind({ modkey, "Shift" }, "S", oxwm.spawn({ "flameshot", "gui" }))
oxwm.key.bind({ modkey, "Shift" }, "s", oxwm.spawn({ "flameshot", "gui" }))
oxwm.key.bind({}, "Print", oxwm.spawn({ "flameshot", "gui" }))
-- Screen recording with SimpleScreenRecorder
oxwm.key.bind({ modkey, "Shift" }, "Z", oxwm.spawn({ "simplescreenrecorder" }))
oxwm.key.bind({ modkey }, "A", oxwm.client.kill()) 

-- Keybind overlay - Shows important keybindings on screen
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())

-- Window state toggles
oxwm.key.bind({ modkey }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())

-- Layout management
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.layout.set("normie"))
oxwm.key.bind({ modkey }, "C", oxwm.layout.set("tiling"))
-- Cycle through layouts
oxwm.key.bind({ modkey }, "N", oxwm.layout.cycle())

-- Master area controls (tiling layout)

-- Decrease/Increase master area width
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5))
-- Increment/Decrement number of master windows
oxwm.key.bind({ modkey }, "I", oxwm.inc_num_master(1))
oxwm.key.bind({ modkey }, "P", oxwm.inc_num_master(-1))

-- Gaps toggle
oxwm.key.bind({ modkey }, "Q", oxwm.toggle_gaps())

-- Window manager controls
oxwm.key.bind({ modkey, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

-- Focus movement [1 for up in the stack, -1 for down]
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))

-- Window movement (swap position in stack)
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- Multi-monitor support

-- Focus next/previous Monitors
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1))
-- Move window to next/previous Monitors
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Workspace (tag) navigation
-- Switch to workspace N (tags are 0-indexed, so tag "1" is index 0)
-- AZERTY: top row unshifted = &/é/"/'/(/-/è/_/ç
local tag_keys = {
    "ampersand",
    "eacute",
    "quotedbl",
    "apostrophe",
    "parenleft",
    "minus",
    "egrave",
    "underscore",
    "ccedilla",
}

for index, key in ipairs(tag_keys) do
    local tag_index = index - 1
    oxwm.key.bind({ modkey }, key, oxwm.tag.view(tag_index))
    oxwm.key.bind({ modkey, "Shift" }, key, oxwm.tag.move_to(tag_index))
    oxwm.key.bind({ modkey, "Control" }, key, oxwm.tag.toggleview(tag_index))
    oxwm.key.bind({ modkey, "Control", "Shift" }, key, oxwm.tag.toggletag(tag_index))
    oxwm.key.bind({ modkey, "Alt" }, key, oxwm.tag.move_to_and_view(tag_index))
end

-------------------------------------------------------------------------------
-- Volume controls
-------------------------------------------------------------------------------
-- F1/F2/F3 + XF86 multimedia keys via pactl (PulseAudio)
oxwm.key.bind({}, "F1", oxwm.spawn({ "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle" }))
oxwm.key.bind({}, "F2", oxwm.spawn({ "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%" }))
oxwm.key.bind({}, "F3", oxwm.spawn({ "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%" }))

oxwm.key.bind({}, "XF86AudioMute", oxwm.spawn({ "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle" }))
oxwm.key.bind({}, "XF86AudioLowerVolume", oxwm.spawn({ "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%" }))
oxwm.key.bind({}, "XF86AudioRaiseVolume", oxwm.spawn({ "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%" }))

-------------------------------------------------------------------------------
-- Floating window resize (requires xdotool)
-------------------------------------------------------------------------------
-- Mod+Alt+H/J/K/L to resize the focused floating window by 20px
oxwm.key.bind({ modkey, "Alt" }, "H", oxwm.spawn({ "xdotool", "getactivewindow", "windowsize", "--relative", "--", "-20", "0" }))
oxwm.key.bind({ modkey, "Alt" }, "L", oxwm.spawn({ "xdotool", "getactivewindow", "windowsize", "--relative", "--", "20", "0" }))
oxwm.key.bind({ modkey, "Alt" }, "J", oxwm.spawn({ "xdotool", "getactivewindow", "windowsize", "--relative", "--", "0", "20" }))
oxwm.key.bind({ modkey, "Alt" }, "K", oxwm.spawn({ "xdotool", "getactivewindow", "windowsize", "--relative", "--", "0", "-20" }))

-------------------------------------------------------------------------------
-- Advanced: Keychords
-------------------------------------------------------------------------------
-- Keychords allow you to bind multiple-key sequences (like Emacs or Vim)
-- Format: {{modifiers}, key1}, {{modifiers}, key2}, ...
-- Example: Press Mod4+Space, then release and press T to spawn a terminal
oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "T" }
}, oxwm.spawn_terminal())

oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "F" }
}, oxwm.spawn({ "sh", "-c", "firefox" }))

-------------------------------------------------------------------------------
-- Autostart
-------------------------------------------------------------------------------
-- Commands to run once when OXWM starts
-- Uncomment and modify these examples, or add your own

-- oxwm.autostart("picom")                                  
oxwm.autostart("feh --bg-scale ~/wallpapers/wallpaper1.jpg") 
oxwm.autostart("dunst")
-- oxwm.autostart("nm-applet")

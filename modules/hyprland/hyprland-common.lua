-- ========== DEFAULT PROGRAMS ==========

local terminal = "wezterm"
local browser = "brave"
local files = "nemo"

-- ========== AUTOSTART ==========
-- Host-specific extras (e.g. bright) live in the per-host file.

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("noctalia")
  hl.exec_cmd("wallpaperSchedule")
end)

-- ========== SENSITIVITY ==========

hl.device({ name = "logitech-g403-1", sensitivity = -0.5 })
hl.device({ name = "compx-vxe-nordicmouse-1k-dongle-1", sensitivity = -0.5 })
hl.device({ name = "compx-vxe-r1-pro-max-consumer-control-1", sensitivity = -0.5 })
hl.device({ name = "compx-vxe-r1-pro-max-1", sensitivity = -0.5 })
hl.device({ name = "dell09ed:00-27c6:01e0-touchpad", sensitivity = 0.1 })

-- ========== NOCTALIA ==========
local noctalia_ok, noctalia = pcall(require, "noctalia")
if noctalia_ok and noctalia and noctalia.apply_theme then
  noctalia.apply_theme()
end

local function to_argb(rgb, fallback)
  local hex = type(rgb) == "string" and rgb:match("rgb%(([%x]+)%)")
  return hex and tonumber("0xff" .. hex) or fallback
end

local palette = (noctalia_ok and noctalia and noctalia.colors) or {}
local primary = to_argb(palette.primary, 0xffc39189)
local secondary = to_argb(palette.secondary, 0xffbaa278)

-- ========== MONITORS ==========

hl.monitor({ output = "DP-2", mode = "1920x1080@165", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", disabled = true })
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1.2 })

-- ========== NIX PLUGINS ==========
-- plugins.nix writes nix-plugins.lua with absolute /nix/store paths
-- (home-manager's `hyprctl plugin load` line only lands in the ignored .conf).
pcall(require, "nix-plugins")

-- ========== LOOK AND FEEL ==========

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    resize_on_border = false,
    allow_tearing = false,
    layout = "master",
  },
  decoration = {
    rounding = 2,
    rounding_power = 3,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = { enabled = true, range = 4, render_power = 3 },
    blur = { enabled = false, size = 8, passes = 1, vibrancy = 0.1696 },
  },
})

-- ========== LAYOUTS ==========

hl.config({
  dwindle = { preserve_split = true, force_split = 2 },
  master = { new_status = "slave", new_on_active = "before" },
  scrolling = { column_width = 0.6, focus_fit_method = 0, follow_min_visible = 0.1 },
})

-- ========== ANIMATIONS ==========

hl.config({ animations = { enabled = true } })

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- ========== INPUT ==========

hl.config({
  input = {
    kb_layout = "pl",
    numlock_by_default = true,
    follow_mouse = 1,
    touchpad = { natural_scroll = false },
  },
})

-- ========== GESTURES ==========

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER", action = "move" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER SHIFT", action = "resize" })

-- ========== KEYBINDINGS ==========

local mainMod = "SUPER"

hl.config({
  binds = { allow_workspace_cycles = true, workspace_back_and_forth = true },
})

-- Launchers
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("noctalia msg bar-toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-open control-center notifications"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))

-- Windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.float())
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
-- NOTE: SUPER+P is bound twice upstream (pin above, pseudo below); last wins.
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Layout switchers
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl keyword general:layout master"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("hyprctl keyword general:layout dwindle"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprctl keyword general:layout scrolling"))

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10 on current monitor, move (SHIFT), silent move (CTRL+SHIFT)
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(mainMod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous_per_monitor" }))

-- Screenshots
hl.bind("print", hl.dsp.exec_cmd("screencapture shot monitor"))
hl.bind(mainMod .. " + print", hl.dsp.exec_cmd("screencapture shot all"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("screencapture shot area"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("screencapture record area"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("screencapture extract area pl"))
hl.bind(mainMod .. " + CTRL + SHIFT + T", hl.dsp.exec_cmd("screencapture extract area eng"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a -q -r"))

-- Media keys (bindel = locked + repeating, bindl = locked)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("F9", hl.dsp.exec_cmd("wpctl set-mute -p $(hyprctl activewindow -j | jq '.pid') toggle"), { locked = true })
hl.bind("F12", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Mouse drag/resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ========== WINDOW RULES ==========

hl.window_rule({
  name = "windowrule-1",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "windowrule-2",
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

-- Smart gaps/borders part 2 (part 1 is WORKSPACE RULES below)
hl.window_rule({
  name = "windowrule-3",
  match = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  name = "windowrule-4",
  match = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  name = "windowrule-emulator",
  match = { class = "^(Emulator)$" },
  float = true,
})

hl.window_rule({
  name = "windowrule-waydroid",
  match = { class = "(?i).*waydroid.*" },
  float = true,
})

-- ========== WORKSPACE RULES ==========
-- Smart gaps/borders part 1 (deduped: monitors.nix + window-rules.nix emitted these twice).

hl.workspace_rule({ workspace = "w[tv1]", gaps_in = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_in = 0, gaps_out = 0 })

-- ========== XWAYLAND ==========

hl.config({ xwayland = { force_zero_scaling = true } })

-- ========== PLUGINS (GLOVIEW) ==========

hl.config({
  plugin = {
    gloview = {
      layout = "rows",
      gap = 40,
      padding = 80,
      padding_top = 30,
      padding_bottom = 80,
      duration = 0,
      blur = 0.7,
      switch_animation = 0,
      anchor = "top",
      focus_follows_mouse = 0,
      scroll_switches_workspace = 1,
      passthrough_keys = 0,
      exit_on_click = 1,
      exit_on_switch = 0,
      key_close = "escape",
      key_next_workspace = "e",
      key_prev_workspace = "q",
      key_activate = "tab, enter",
      key_close_window = "c",
      key_left = "a, left",
      key_right = "d, right",
      key_up = "w, up",
      key_down = "s, down",
      key_desktop = "z",
      key_all_workspaces = "x",
      key_workspace = "1,2,3,4,5,6,7,8,9,0",
      show_all_workspaces = 0,
      show_empty = 1,
      dynamic_workspaces = 1,
      autodelete_empty = 1,
      show_workspace_labels = 1,
      show_window_labels = 1,
      show_special = 0,
      strip_all_card = 0,
      drag_to_swap = 1,
      switch_on_drop = 0,
      switch_on_new_workspace = 1,
      hide_top_layers = 0,
      hide_overlay_layers = 0,
      above_namespaces = "",
      debug_logs = 0,
      select_border_size = 4,
      select_border = primary,
      backdrop_color = 0x73070a10,
      strip_band_color = 0x24000000,
      strip_card_color = 0x3a0e131c,
      strip_active_color = primary,
      strip_active_border = primary,
      strip_hover_border = secondary,
      strip_active_border_size = 1,
      strip_hover_border_size = 1,
      strip_plus_color = 0xd0eef4ff,
      preview_bg = 0xff14181f,
      shadow_color = 0x70000000,
      hover_border = secondary,
      hover_border_size = 2,
    },
  },
})

hl.bind("SUPER + TAB", hl.plugin.gloview.allworkspaces)

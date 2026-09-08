-- See https://wiki.hypr.land/Configuring/Start/
require("hyprland-common")

-- ========== HOST: DESKTOP ==========

-- ========== AUTOSTART ==========

hl.on("hyprland.start", function()
  hl.exec_cmd("sleep 1 && bright 50 4000")
end)

-- ========== WORKSPACE RULES ==========

hl.workspace_rule({ workspace = 1, monitor = "DP-2" })

-- ========== WINDOW RULES ==========

hl.window_rule({
  name = "windowrule-pwvucontrol",
  match = { class = "^(com\\.saivert\\.pwvucontrol)$" },
  float = true,
  size = { 1060, 570 },
  move = { 850, 470 },
})

hl.window_rule({
  name = "windowrule-wifitui",
  match = { class = "^(wifitui)$" },
  float = true,
  size = { 600, 720 },
  move = { 1315, 315 },
})

hl.window_rule({
  name = "windowrule-localsend",
  match = { class = "^(localsend_app)$" },
  float = true,
  center = true,
  size = { 700, 900 },
})

-- For Noctalia Color templates
require("noctalia").apply_theme()

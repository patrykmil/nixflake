require("hyprland-common")

-- ========== HOST: LAPTOP ==========

-- ========== AUTOSTART ==========

hl.on("hyprland.start", function()
  hl.exec_cmd("sleep 1 && bright 100 4600")
end)

{
  pkgs,
  hostName,
  inputs,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableDynamicTheming = false;
  };

  services.cliphist.enable = true;

  home.file.".config/DankMaterialShell/settings.json".text = ''
    {
      "currentThemeName": "blue",
      "customThemeFile": "",
      "matugenScheme": "scheme-tonal-spot",
      "dankBarTransparency": 1,
      "dankBarWidgetTransparency": 1,
      "popupTransparency": 1,
      "dockTransparency": 1,
      "use24HourClock": true,
      "useFahrenheit": false,
      "nightModeEnabled": false,
      "weatherLocation": "Kraków, województwo małopolskie",
      "weatherCoordinates": "50.0469432,19.9971534",
      "useAutoLocation": false,
      "weatherEnabled": true,
      "showLauncherButton": true,
      "showWorkspaceSwitcher": true,
      "showFocusedWindow": true,
      "showWeather": true,
      "showMusic": true,
      "showClipboard": true,
      "showCpuUsage": true,
      "showMemUsage": true,
      "showCpuTemp": true,
      "showGpuTemp": true,
      "selectedGpuIndex": 0,
      "enabledGpuPciIds": [],
      "showSystemTray": true,
      "showClock": true,
      "showNotificationButton": true,
      "showBattery": true,
      "showControlCenterButton": true,
      "controlCenterShowNetworkIcon": true,
      "controlCenterShowBluetoothIcon": false,
      "controlCenterShowAudioIcon": true,
      "controlCenterWidgets": [
        {
          "id": "volumeSlider",
          "enabled": true,
          "width": 50
        },
        {
          "id": "wifi",
          "enabled": true,
          "width": 50
        },
        {
          "id": "audioOutput",
          "enabled": true,
          "width": 50
        },
        {
          "id": "audioInput",
          "enabled": true,
          "width": 50
        },
        {
          "id": "nightMode",
          "enabled": true,
          "width": 50
        },
        {
          "id": "idleInhibitor",
          "enabled": true,
          "width": 50
        }
      ],
      "showWorkspaceIndex": false,
      "showWorkspacePadding": false,
      "showWorkspaceApps": true,
      "maxWorkspaceIcons": 3,
      "workspacesPerMonitor": true,
      "workspaceNameIcons": {},
      "waveProgressEnabled": true,
      "clockCompactMode": true,
      "focusedWindowCompactMode": false,
      "runningAppsCompactMode": false,
      "runningAppsCurrentWorkspace": true,
      "clockDateFormat": "ddd d",
      "lockDateFormat": "dddd, MMMM d",
      "mediaSize": 1,
      "dankBarLeftWidgets": [
        {
          "id": "spacer",
          "enabled": true,
          "size": 20
        },
        {
          "id": "launcherButton",
          "enabled": true
        },
        {
          "id": "spacer",
          "enabled": true,
          "size": 10
        },
        {
          "id": "workspaceSwitcher",
          "enabled": true
        },
        {
          "id": "focusedWindow",
          "enabled": true
        }
      ],
      "dankBarCenterWidgets": [],
      "dankBarRightWidgets": [
        ${
          if hostName == "laptop" then
            ''
              {
                "id": "battery",
                "enabled": true
              },
              {
                "id": "spacer",
                "enabled": true,
                "size": 10
              },
            ''
          else
            ""
        }
        {
          "id": "clipboard",
          "enabled": true
        },
        {
          "id": "spacer",
          "enabled": true,
          "size": 10
        },
        {
          "id": "systemTray",
          "enabled": true
        },
        {
          "id": "notificationButton",
          "enabled": true
        },
        {
          "id": "spacer",
          "enabled": true,
          "size": 10
        },
        {
          "id": "controlCenterButton",
          "enabled": true
        },
        {
          "id": "spacer",
          "enabled": true,
          "size": 10
        },
        {
          "id": "clock",
          "enabled": true
        },
        {
          "id": "spacer",
          "enabled": true,
          "size": 20
        }
      ],
      "appLauncherViewMode": "grid",
      "spotlightModalViewMode": "grid",
      "networkPreference": "auto",
      "iconTheme": "System Default",
      "useOSLogo": true,
      "osLogoColorOverride": "",
      "osLogoBrightness": 0.5,
      "osLogoContrast": 1,
      "fontFamily": "Maple Mono NF",
      "monoFontFamily": "CaskaydiaMono Nerd Font Mono",
      "fontWeight": 400,
      "fontScale": 1,
      "notepadUseMonospace": true,
      "notepadFontFamily": "",
      "notepadFontSize": 14,
      "notepadShowLineNumbers": false,
      "notepadTransparencyOverride": -1,
      "notepadLastCustomTransparency": 0.7,
      "gtkThemingEnabled": false,
      "qtThemingEnabled": false,
      "showDock": false,
      "dockAutoHide": false,
      "dockGroupByApp": false,
      "dockOpenOnOverview": false,
      "cornerRadius": 0,
      "notificationOverlayEnabled": false,
      "dankBarAutoHide": false,
      "dankBarOpenOnOverview": false,
      "dankBarVisible": true,
      "dankBarSpacing": 0,
      "dankBarBottomGap": -16,
      "dankBarInnerPadding": 6,
      "dankBarSquareCorners": false,
      "dankBarNoBackground": true,
      "dankBarGothCornersEnabled": false,
      "dankBarAtBottom": true,
      "lockScreenShowPowerActions": true,
      "hideBrightnessSlider": false,
      "widgetBackgroundColor": "sch",
      "surfaceBase": "sc",
      "notificationTimeoutLow": 5000,
      "notificationTimeoutNormal": 5000,
      "notificationTimeoutCritical": 0,
      "screenPreferences": {}
    }
  '';
}

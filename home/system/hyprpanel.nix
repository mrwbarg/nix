{ config, pkgs, home-manager, hyprpanel, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [
    hyprpanel.overlay
  ];


  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  home-manager.users.mrwbarg = {
    home.packages = with pkgs; [
      hyprpanel
      networkmanager
      pipewire
      libgtop
      bluez
      wl-clipboard
      brightnessctl
      gnome.gnome-bluetooth
      power-profiles-daemon
      gpu-screen-recorder
      grimblast
      hyprpicker
    ];

    home.file.".cache/ags/hyprpanel/profile.png" = {
      source = ../profile.png;
    };

    home.file.".cache/ags/hyprpanel/options.json" = {
      text = # json
        ''
          {
            "bar.layouts": {
              "0": {
                "left": [
                  "dashboard",
                  "workspaces",
                  "windowtitle"
                ],
                "middle": [
                  "clock",
                  "media"
                ],
                "right": [
                  "systray",
                  "volume",
                  "bluetooth",
                  "battery",
                  "network",
                  "notifications"
                ]
              }
            },
            "bar.customModules.updates.pollingInterval": 1440000,
            "theme.bar.location": "top",
            "theme.bar.buttons.modules.netstat.enableBorder": false,
            "bar.customModules.netstat.dynamicIcon": false,
            "menus.clock.time.military": true,
            "menus.clock.time.hideSeconds": true,
            "menus.clock.weather.unit": "metric",
            "theme.font.name": "FiraCode Nerd Font",
            "theme.font.size": "1.2rem",
            "theme.font.weight": 500,
            "tear": true,
            "menus.transition": "crossfade",
            "menus.transitionTime": 200,
            "scalingPriority": "hyprland",
            "theme.bar.scaling": 90,
            "theme.notification.scaling": 90,
            "theme.osd.scaling": 90,
            "theme.bar.menus.menu.dashboard.scaling": 90,
            "theme.bar.menus.menu.dashboard.confirmation_scaling": 90,
            "theme.bar.menus.menu.media.scaling": 90,
            "theme.bar.menus.menu.volume.scaling": 90,
            "theme.bar.menus.menu.network.scaling": 90,
            "theme.bar.menus.menu.bluetooth.scaling": 90,
            "theme.bar.menus.menu.battery.scaling": 90,
            "theme.bar.menus.menu.clock.scaling": 90,
            "theme.bar.menus.menu.notifications.scaling": 90,
            "theme.tooltip.scaling": 90,
            "theme.bar.floating": true,
            "theme.bar.buttons.enableBorders": false,
            "theme.bar.outer_spacing": "0.4em",
            "theme.bar.buttons.y_margins": "0.5em",
            "theme.bar.buttons.spacing": "0.2em",
            "theme.bar.buttons.padding_x": "0.6rem",
            "theme.bar.buttons.padding_y": "0.2rem",
            "theme.bar.layer": "top",
            "theme.bar.dropdownGap": "2.8em",
            "theme.bar.margin_top": "0.2em",
            "theme.bar.margin_bottom": "0em",
            "theme.bar.margin_sides": "0.6em",
            "bar.launcher.icon": "",
            "theme.bar.buttons.dashboard.enableBorder": true,
            "theme.bar.buttons.workspaces.enableBorder": false,
            "bar.workspaces.showAllActive": true,
            "theme.bar.buttons.workspaces.fontSize": "1.2em",
            "bar.workspaces.show_icons": false,
            "bar.workspaces.show_numbered": false,
            "bar.workspaces.numbered_active_indicator": "highlight",
            "theme.bar.buttons.workspaces.smartHighlight": true,
            "bar.workspaces.showApplicationIcons": true,
            "bar.workspaces.showWsIcons": true,
            "bar.workspaces.applicationIconOncePerWorkspace": true,
            "bar.workspaces.workspaces": 6,
            "bar.workspaces.workspaceMask": false,
            "theme.bar.buttons.windowtitle.enableBorder": false,
            "bar.windowtitle.custom_title": true,
            "theme.bar.buttons.volume.enableBorder": false,
            "theme.bar.buttons.network.enableBorder": false,
            "bar.network.label": true,
            "bar.network.showWifiInfo": true,
            "bar.network.truncation": true,
            "theme.bar.buttons.battery.enableBorder": false,
            "theme.bar.buttons.systray.enableBorder": false,
            "theme.bar.buttons.clock.enableBorder": false,
            "bar.clock.format": "%Y-%m-%d %H:%M:%S",
            "bar.clock.icon": "󰸗",
            "bar.clock.showIcon": true,
            "bar.clock.showTime": true,
            "bar.media.show_active_only": true,
            "theme.bar.buttons.notifications.enableBorder": false,
            "bar.notifications.hideCountWhenZero": true,
            "bar.notifications.show_total": false,
            "notifications.position": "top right",
            "theme.osd.enable": true,
            "theme.osd.active_monitor": true,
            "theme.osd.margins": "0px 5px 0px 0px",
            "theme.osd.muted_zero": true,
            "menus.bluetooth.batteryState": "connected",
            "menus.bluetooth.showBattery": true,
            "menus.volume.raiseMaximumVolume": true,
            "menus.clock.weather.location": "Rio de Janeiro",
            "menus.clock.weather.enabled": false,
            "menus.dashboard.powermenu.avatar.image": "/home/mrwbarg/Downloads/profile.png",
            "menus.dashboard.stats.enable_gpu": false,
            "menus.dashboard.shortcuts.enabled": true,
            "menus.dashboard.directories.enabled": false,
            "theme.bar.menus.monochrome": false,
            "wallpaper.pywal": true,
            "theme.bar.transparent": true,
            "theme.bar.buttons.style": "default"
          }
        '';
    };
  };
}

{ config, pkgs, home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.users.mrwbarg = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        autogenerated = 0;
        general = {
          gaps_in = 3;
          gaps_out = [5 10 10 10];
          border_size = 1;
        };
        decoration = {
          rounding = 5;
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
        input = {
          kb_layout = "br";
          kb_variant = "nodeadkeys";
          natural_scroll = true;
          touchpad = {
            natural_scroll = true;
          };
        };
        monitor = ",preferred,auto,1.25";

        # binds
        "$mod" = "SUPER";
        bind = [
          # programs
          "$mod, Q, exec, kitty"
          "$mod, W, killactive"
          "$mod, O, exit"
          "$mod, E, exec, nautilus"
          ''$mod, SPACE, exec, rofi -show drun -show-icons''

          # workspaces
          "$mod, H, workspace, -1"
          "$mod, L, workspace, +1"
          "$mod, left, workspace, -1"
          "$mod, right, workspace, +1"
          "$mod ALT, H, movefocus, l"
          "$mod ALT, J, movefocus, u"
          "$mod ALT, K, movefocus, d"
          "$mod ALT, L, movefocus, r"
          "$mod ALT, left, movefocus, l"
          "$mod ALT, up, movefocus, u"
          "$mod ALT, down, movefocus, d"
          "$mod ALT, right, movefocus, r"
          "$mod SHIFT, H, movetoworkspace, -1"
          "$mod SHIFT, L, movetoworkspace, +1"
          "$mod SHIFT, left, movetoworkspace, -1"
          "$mod SHIFT, right, movetoworkspace, +1"
          "$mod CTRL, left, swapwindow, l"
          "$mod CTRL, up, swapwindow, u"
          "$mod CTRL, down, swapwindow, d"
          "$mod CTRL, right, swapwindow, r"
          "$mod CTRL, a, resizeactive, -10 0"
          "$mod CTRL, w, resizeactive, 0 -10"
          "$mod CTRL, s, resizeactive, 0 10"
          "$mod CTRL, d, resizeactive, 10 0"
        ];

        exec-once = [
          "hyprpanel"
        ];
      };
    };
  };
}

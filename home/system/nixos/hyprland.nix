{ pkgs, home-manager, ... }:
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
          gaps_out = [ 5 10 10 10 ];
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
          # move left and right
          "$mod, H, workspace, -1"
          "$mod, L, workspace, +1"
          "$mod, left, workspace, -1"
          "$mod, right, workspace, +1"
          # switch focus
          "$mod ALT, H, movefocus, l"
          "$mod ALT, J, movefocus, u"
          "$mod ALT, K, movefocus, d"
          "$mod ALT, L, movefocus, r"
          "$mod ALT, left, movefocus, l"
          "$mod ALT, up, movefocus, u"
          "$mod ALT, down, movefocus, d"
          "$mod ALT, right, movefocus, r"
          # move active window to workspace
          "$mod SHIFT, H, movetoworkspace, -1"
          "$mod SHIFT, L, movetoworkspace, +1"
          "$mod SHIFT, left, movetoworkspace, -1"
          "$mod SHIFT, right, movetoworkspace, +1"
          # swap windows
          "$mod CTRL, left, swapwindow, l"
          "$mod CTRL, up, swapwindow, u"
          "$mod CTRL, down, swapwindow, d"
          "$mod CTRL, right, swapwindow, r"
          "$mod CTRL, H, swapwindow, l"
          "$mod CTRL, J, swapwindow, u"
          "$mod CTRL, K, swapwindow, d"
          "$mod CTRL, L, swapwindow, r"
          # resize
          "$mod ALT, R, submap, resize"
          "$mod, Print, exec, grimblast --notify --cursor copy area"
        ];
        bindl = [
          ", switch:on:Lid Switch, exec, hyprlock --immediate & disown && hyprctl dispatch dpms off"
          ", sswitch:off:Lid Switch, exec, hyprctl dispatch dpms on"
        ];
        binde = [
          # function keys
          "$mod, F8, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          "$mod, F9, exec, pactl set-sink-volume @DEFAULT_SINK@ -1%"
          "$mod, F10, exec, pactl set-sink-volume @DEFAULT_SINK@ +1%"
          "$mod, F11, exec, brightnessctl set 1%-"
          "$mod, F12, exec, brightnessctl set 1%+"
        ];
        

        exec-once = [
          "hyprlock"
          "hyprpanel"
        ];
      };
      extraConfig = ''
          # resize
          submap = resize
          binde = , left, resizeactive, -25 0
          binde = , up, resizeactive, 0 -25
          binde = , down, resizeactive, 0 25
          binde = , right, resizeactive, 25 0
          bind = , escape, submap, reset
          submap = reset
        '';
    };
  };
}
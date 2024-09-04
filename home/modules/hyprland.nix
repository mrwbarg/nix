{ config, pkgs, home-manager, attrs, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.users.mrwbarg = {
    home.packages = with pkgs; [
      kitty
      waybar
      dunst
      swww
      networkmanagerapplet
      networkmanager
      gnome.nautilus
      pkgs.nerdfonts
      dmenu
      networkmanager_dmenu
      pavucontrol
    ];

    programs.waybar = {
      enable = true;
      catppuccin.enable = true;
      style = ''
        * {
          font-family: FiraCode Nerd Font;
          font-size: 17px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: @text;
          margin: 8px 8px;
        }

        #workspaces {
          border-radius: 1rem;
          margin: 5px;
          background-color: @surface0;
          margin-left: 1rem;
          padding-bottom: 0.1rem;
          padding-top: 0.1rem;
        }

        #workspaces button {
          color: @mantle;
          border-radius: 1rem;
          padding: 0.2rem 1.0rem 0.2rem 1.0rem;
          margin-top: 0.1rem;
          margin-bottom: 0.1rem;
        }

        #workspaces button.active {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.2rem 0.6rem 0.2rem 0.6rem;
          margin-left: 0.6rem;
          margin-right: 0.6rem;
          background-color: @surface1;
        }

        #workspaces button:hover {
          color: @pink;
          border-radius: 1rem;
          padding: 0.2rem 0.6rem 0.2rem 0.6rem;
          background-color: @surface1;
        }

        #network {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.2rem 0.6rem 0.2rem 0.6rem;
          margin-right: 5px;
        }

        #clock,
        #battery,
        #network,
        #pulseaudio,
        #backlight {
          background-color: @surface0;
          padding: 0.5rem 1rem;
          margin: 5px 0;
        }

        #clock {
          color: @lavender;
          border-radius: 1rem;
          padding-left: 2rem;
          padding-right: 2rem;
        }

        #battery {
          color: @blue;
          border-radius: 1rem;
          margin-right: 5px;
          margin-left: 5px;
          padding-bottom: 0.1rem;
          padding-top: 0.1rem;
        }

        #pulseaudio {
          color: @mauve;
          border-radius: 1rem;
          padding: 0.2rem 0.8rem 0.2rem 0.8rem;
          margin-right: 5px;
        }

        #backlight {
          color: @peach;
          border-radius: 1rem;
          padding: 0.2rem 0.6rem 0.2rem 0.6rem;
          margin-right: 5px;
        }

        #battery.charging {
          color: @green;
        }

        #battery.warning:not(.charging) {
          color: @red;
        }
      '';
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ "hyprland/workspaces" "custom/weather" ];
          modules-center = [ "clock" ];
          modules-right = [ "backlight" "pulseaudio" "network" "battery" ];

          "hyprland/workspaces" = {
            format = "{name}";
            persistent-workspaces = {
              "*" = 5;
            };
          };

          "clock" = {
            format = "{:%Y-%m-%d %H:%M:%S}";
            interval = 1;
          };

          "battery" = {
            "interval" = 1;
            "states" = {
              "warning" = 50;
              "critical" = 30;
            };
            "format" = "{capacity}% {icon}";
            "format-icons" = [ " " " " " " " " " " ];
            "max-length" = 30;
          };
          "pulseaudio" = {
            "format" = "{volume}% {icon}";
            "format-bluetooth" = "{volume}% {icon}";
            "format-muted" = "0% ";
            "format-icons" = {
              "headphone" = "";
              "default" = [ "" " " " " ];
            };
            "scroll-step" = 1;
            "on-click" = "pavucontrol";
            "ignored-sinks" = [ "Easy Effects Sink" ];
          };

          "network" = {
            "interface" = "wlo1";
            "format-wifi" = "{signalStrength}%  ";
            "format-disconnected" = "0%  ";
            "tooltip-format-wifi" = "{essid}";
            "tooltip-format-disconnected" = "Disconnected";
            "max-length" = 50;
            "on-click" = "networkmanager_dmenu";
          };

          "backlight" = {
            "device" = "intel_backlight";
            "format" = "{percent}% {icon}";
            "format-icons" = [ " " ];
          };
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      catppuccin.enable = true;
      settings = {
        autogenerated = 0;

        general = {
          gaps_in = 3;
          gaps_out = 10;
          border_size = 1;
        };
        decoration = {
          rounding = 5;
        };

        "$mod" = "SUPER";
        bind = [
          # programs
          "$mod, Q, exec, kitty"
          "$mod, W, killactive"
          "$mod, O, exit"
          "$mod, E, exec, nautilus"
          ''$mod, SPACE, exec, rofi -show drun -show-icons ''

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
        ];
        input = {
          kb_layout = "br";
          kb_variant = "nodeadkeys";
          natural_scroll = true;
          touchpad = {
            natural_scroll = true;
          };
        };
        monitor = ",preferred,auto,1.25";
        exec-once = [
          "waybar"
          "dunst"
          "hyprctl setcursor catppuccin-mocha-dark-cursors 24"
        ];
      };
    };
  };
}

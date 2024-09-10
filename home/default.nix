{ config, pkgs, home-manager, catppuccin, attrs, lib, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./modules/hyprland.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  home-manager.users.mrwbarg = { config, lib, ... }: {
    imports = [
      catppuccin.homeManagerModules.catppuccin
    ];
    catppuccin.enable = true;
    home = {
      stateVersion = "24.05";
      username = "mrwbarg";
      homeDirectory = "/home/mrwbarg";
    };

    home.file.".local/share/rofi/themes" = {
      recursive = true;
      source = ./modules/rofi/themes;
    };
    home.file.".local/share/walpapers" = {
      recursive = true;
      source = ./walpapers;
    };
    home.file.".config/networkmanager-dmenu/config.ini" = {
      source = ./modules/rofi/config.ini;
    };

    gtk = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        size = 10;
      };
      catppuccin.enable = true;

    };

    home.pointerCursor = {
      gtk.enable = true;
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };

    services = {
      dunst = {
        enable = true;
        catppuccin.enable = true;
        settings = {
          global = {
            width = 400;
            height = 400;
            offset = "8x0";
            origin = "top-right";
            transparency = 10;
            gap_size = 2;
            corner_radius = 5;
            frame_width = 1;
            font = "FiraCode Nerd Font 10";
          };

        };

      };
    };

    programs = {
      home-manager.enable = true;
      git = {
        enable = true;
        userEmail = "mrwbarg@gmail.com";
        userName = "Mauricio Barg";
      };
      firefox = {
        enable = true;
        policies = {
          ExtensionSettings = {
            "*".installation_mode = "blocked";
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # Privacy Badger:
            "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
      vscode = {
        enable = true;
      };
      fish.enable = true;
      kitty.enable = true;

      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig =
          let
            inherit (config.lib.formats.rasi) mkLiteral;
          in
          {
            modi = "drun,calc,powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=logout/hibernate/suspend/reboot/shutdown";
            sidebar-mode = true;
            display-drun = "   Apps ";
            display-calc = " Calculator";
            "// this-is-a-work-around" = mkLiteral ''
            
powermenu {
  display-name: " Power";
}
            // '';
          };
        theme = lib.mkForce "~/.local/share/rofi/themes/catppuccin-mocha.rasi";
        plugins = [
          pkgs.rofi-power-menu
          (pkgs.rofi-calc.override {
            rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
          })
        ];
      };
    };
  };
}

{ config, pkgs, home-manager, catppuccin, attrs, lib, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    catppuccin.nixosModules.catppuccin
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

    programs = {
      home-manager.enable = true;
      git = {
        enable = true;
        userEmail = "mrwbarg@gmail.com";
        userName = "Mauricio Barg";
      };
      firefox.enable = true;
      vscode.enable = true;
      fish.enable = true;
      kitty.enable = true;
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig = let 
          inherit (config.lib.formats.rasi) mkLiteral;
         in
         {
            modi = "drun,calc,powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
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

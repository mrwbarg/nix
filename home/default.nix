{ config, pkgs, home-manager, catppuccin, attrs, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    catppuccin.nixosModules.catppuccin
    ./modules/hyprland.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  home-manager.users.mrwbarg = {
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
      source = ./modules/rofi;
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
      };
    };
  };
}

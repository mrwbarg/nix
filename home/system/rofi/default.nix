{ config, pkgs, home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager

  ];


  home-manager.users.mrwbarg = { config, lib, ... }: {
    home.file.".local/share/rofi/themes" = {
      recursive = true;
      source = ./themes;
    };
    programs = {
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig =
          let
            inherit (config.lib.formats.rasi) mkLiteral;
          in
          {
            modi = "drun,calc";
            sidebar-mode = true;
            display-drun = "   Apps ";
            display-calc = " Calculator";
          };
        theme = lib.mkForce "~/.local/share/rofi/themes/catppuccin-mocha.rasi";
        plugins = [
          (pkgs.rofi-calc.override {
            rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
          })
        ];
      };
    };
  };
}

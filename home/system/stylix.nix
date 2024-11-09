{ config, pkgs, home-manager, stylix, ... }:
{


  stylix = {
    enable = true;
    image = ../walpapers/abstract-swirls.jpg;
  };

  home-manager.users.mrwbarg = { config, lib, ... }: {

    gtk = {
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };

    stylix = {
      autoEnable = true;
      cursor = {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = "catppuccin-mocha-dark-cursors";
        size = 24;
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";

      fonts = {
        serif = {
          package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          name = "FiraCode Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          name = "FiraCode Nerd Font";
        };
        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          name = "FiraCode Nerd Font";
        };

        sizes = {
          applications = 10;
          desktop = 10;
          popups = 10;
          terminal = 12;
        };
      };
    };
  };
}

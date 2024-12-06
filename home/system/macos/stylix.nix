{ pkgs, home-manager-master, stylix, ... }:
{


  stylix = {
    enable = true;
    image = ../../walpapers/abstract-swirls.jpg;
  };

  home-manager.users."mauriciobarg" = { config, lib, ... }: {

    stylix = {
      autoEnable = true;
      targets.vscode.enable = false;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";

      fonts = {
        serif = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };

        sizes = {
          applications = 14;
          desktop = 14;
          popups = 14;
          terminal = 16;
        };
      };
    };
  };
}

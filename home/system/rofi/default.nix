{ pkgs, home-manager, ... }:
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
        extraConfig = {
          modi = "drun,calc";
          sidebar-mode = true;
          display-drun = "   Apps ";
          display-calc = " Calculator";
        };
        theme =
          let
            inherit (config.lib.formats.rasi) mkLiteral;
          in
          lib.mkForce {
            "*" = {
                bg-col = mkLiteral "#${config.lib.stylix.colors.base00}";
                bg-col-light = mkLiteral "#${config.lib.stylix.colors.base00}";
                border-col = mkLiteral "#${config.lib.stylix.colors.base00}";
                selected-col = mkLiteral "#${config.lib.stylix.colors.base00}";
                blue = mkLiteral "#${config.lib.stylix.colors.base0D}";
                fg-col = mkLiteral "#${config.lib.stylix.colors.base05}";
                fg-col2 = mkLiteral "#${config.lib.stylix.colors.base08}";
                grey = mkLiteral "#${config.lib.stylix.colors.base04}";
                width = 800;
                font = "FiraCode Nerd Font 12";
            };
            "element-text, element-icon, mode-switcher" = {
                background-color = mkLiteral "inherit";
                text-color = mkLiteral "inherit";
            };
            "window" = {
                height = mkLiteral "360px";
                border = mkLiteral "3px";
                border-color = mkLiteral "@border-col";
                background-color = mkLiteral "@bg-col";
            };
            "mainbox" = {
                background-color = mkLiteral "@bg-col";
            };
            "inputbar" = {
                children = map mkLiteral [ "prompt" "entry" ];
                background-color = mkLiteral "@bg-col";
                border-radius = mkLiteral "5px";
                padding = mkLiteral "2px";
            };
            "prompt" = {
                background-color = mkLiteral "@blue";
                padding = mkLiteral "6px";
                text-color = mkLiteral "@bg-col";
                border-radius = mkLiteral "3px";
                margin = mkLiteral "20px 0px 0px 20px";
            };
            "textbox-prompt-colon" = {
                expand = mkLiteral "false";
                str = ":";
            };
            "entry" = {
                padding = mkLiteral "6px";
                margin = mkLiteral "20px 0px 0px 10px";
                text-color = mkLiteral "@fg-col";
                background-color = mkLiteral "@bg-col";
            };
            "listview" = {
                border = mkLiteral "0px 0px 0px";
                padding = mkLiteral "6px 0px 0px";
                margin = mkLiteral "10px 0px 0px 20px";
                columns = 1;
                lines = 5;
                background-color = mkLiteral "@bg-col";
            };
            "element" = {
              padding = mkLiteral "5px";
              background-color = mkLiteral "@bg-col";
              text-color = mkLiteral "@fg-col";
            };
            "element-icon" = {
              size = mkLiteral "25px";
            };
            "element selected" = {
              background-color = mkLiteral "@selected-col";
              text-color = mkLiteral "@fg-col2";
            };
            "mode-switcher" = {
              spacing = 0;
            };
            "button" = {
              padding = mkLiteral "10px";
              background-color = mkLiteral "@bg-col-light";
              text-color = mkLiteral "@grey";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.5";
            };
            "button selected" = {
              background-color = mkLiteral "@bg-col";
              text-color = mkLiteral "@blue";
            };
            "message" = {
              background-color = mkLiteral "@bg-col-light";
              margin = mkLiteral "2px";
              padding = mkLiteral "2px";
              border-radius = mkLiteral "5px";
            };
            "textbox" = {
              padding = "6px";
              margin = "20px 0px 0px 20px";
              text-color = "@blue";
              background-color = "@bg-col-light";
            };
          };
        plugins = [
          (pkgs.rofi-calc.override {
            rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
          })
        ];
      };
    };
  };
}

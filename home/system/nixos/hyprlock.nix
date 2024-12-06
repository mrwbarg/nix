{ ... }:
{

  home-manager.users.mrwbarg = { config, lib, ... }: {
    programs.hyprlock = {
      enable = true;

      settings = {
        background = {
          path = "/home/mrwbarg/.local/share/walpapers/abstract-swirls.jpg";
          blur_passes = 2;
          blur_size = 7;
          brightness = 0.8;
          contrast = 0.8;
        };

        input-field = {
          size = "250, 45";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgb(${config.lib.stylix.colors.base05})";
          fade_on_empty = true;
          rounding = -1;
          check_color = "rgb(${config.lib.stylix.colors.base0D})";
          fail_color = "rgb(${config.lib.stylix.colors.base08})";
          font_family = "FiraCode Nerd Font";
          placeholder_text = "";
          hide_input = false;
          position = "0, -100";
          halign = "center";
          valign = "center";
        };

        label = [
          {
            text = "$TIME";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            font_family = "FiraCode Nerd Font";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          {

            text = ''cmd[update:1000] echo $(date +"%A, %d de %B")'';
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 22;
            font_family = "FireCode Nerd Font";
            position = "0, 200";
            halign = "center";
            valign = "center";

          }
        ];

        image = {
          size = 200;
          path = "/home/mrwbarg/Pictures/profile.png";
          position = "0, 50";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}

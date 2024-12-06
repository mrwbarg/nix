{ pkgs, home-manager-master, stylix, ... }:
{
  environment.systemPackages = with pkgs; [ 
    yabai
  ];
  services.yabai.enable = true;

  home-manager.users."mauriciobarg" = {
    xdg.configFile = {
      "yabai/yabairc".source = ./yabairc;
    };
  };
 
}

{ pkgs, home-manager-master, ... }:
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

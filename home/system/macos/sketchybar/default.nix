{ pkgs, home-manager-master, ... }:
{
  # NOTE: need to install sbarlua package manually:
  # (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
  environment.systemPackages = with pkgs; [ 
    sketchybar
    lua5_4
  ];
  services.sketchybar.enable = true;

  home-manager.users."mauriciobarg" = {
    xdg.configFile.sketchybar = {
      source = ./config;
      recursive = true;
      executable = true;
      onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
    };
  };
 
}

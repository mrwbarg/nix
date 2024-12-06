{ pkgs, home-manager-master, ... }:
{
  environment.systemPackages = with pkgs; [ 
    skhd
  ];
  services.skhd.enable = true;

  home-manager.users."mauriciobarg" = {
    xdg.configFile = {
      "skhd/skhdrc".source = ./skhdrc;
    };
  };
 
}

{ config, pkgs, home-manager, attrs, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./modules/hyprland.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  home-manager.users.mrwbarg = {
    home = {
      stateVersion = "24.05";
      username = "mrwbarg";
      homeDirectory = "/home/mrwbarg";
    };
    
    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
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
    };
  };
}
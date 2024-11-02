{ config, pkgs, home-manager, hyprpanel, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [
    hyprpanel.overlay
  ];

  home-manager.users.mrwbarg = {
    home.packages = with pkgs; [
      hyprpanel
      hyprpicker
    ];
  };
}

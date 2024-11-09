{ config, pkgs, home-manager, attrs, lib, stylix, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./system/hyprland.nix
    ./system/hyprpanel.nix
    ./system/rofi/default.nix
    ./system/stylix.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";


  home-manager.users.mrwbarg = { config, lib, ... }: {

    home.packages = with pkgs; [
      xplr
      gnome.nautilus
      nerdfonts
      tmux
      hyprcursor
    ];

    home = {
      stateVersion = "24.05";
      username = "mrwbarg";
      homeDirectory = "/home/mrwbarg";
    };

    home.file.".local/share/walpapers" = {
      recursive = true;
      source = ./walpapers;
    };

    programs = {
      home-manager.enable = true;
      vscode.enable = true;
      fish.enable = true;
      kitty.enable = true;
      git = {
        enable = true;
        userEmail = "mrwbarg@gmail.com";
        userName = "Mauricio Barg";
      };
      firefox = {
        enable = true;
        policies = {
          ExtensionSettings = {
            "*".installation_mode = "blocked";
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # Privacy Badger:
            "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
    };
  };
}

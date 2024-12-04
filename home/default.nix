{ config, pkgs, nixpkgs-unstable, home-manager, attrs, lib, stylix, nvchad4nix, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./system/hyprland.nix
    ./system/hyprpanel.nix
    ./system/rofi.nix
    ./system/stylix.nix
    ./system/hyprlock.nix
    ./system/hypridle.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";


  nixpkgs.overlays = [
    (final: prev: {
      nvchad = nvchad4nix.packages."${pkgs.system}".nvchad;
    })
    (final: _prev: {
      unstable = import nixpkgs-unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    })
  ];


  home-manager.users.mrwbarg = { config, lib, ... }: {
    imports = [
      nvchad4nix.homeManagerModule
    ];
    home.packages = with pkgs; [
      xplr
      gnome.nautilus
      nerdfonts
      hyprcursor
      fish
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
    home.file."Pictures/profile.png" = {
      source = ./profile.png;
    };

    home.activation.configure-tide = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_spacing=Sparse --icons='Many icons' --transient=Yes"
    '';

    home.shellAliases = {
      zj = "zellij";
      ls = "ls -lah";
    };

    programs = {
      home-manager.enable = true;
      nvchad = {
        enable = true;
        neovim = pkgs.unstable.neovim;
        hm-activation = true;
      };
      vscode.enable = true;
      kitty = {
        enable = true;
        settings = {
          scrollback_lines = 10000;
          window_padding_width = 4;
        };
        shellIntegration = {
          enableFishIntegration = true;
        };
      };
      xplr = {
        enable = true;
        extraConfig = ''
          xplr.config.general.show_hidden = true
        '';
      };
      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
        '';
        plugins = with pkgs.fishPlugins; [
          {
            name = "tide";
            inherit (tide) src;
          }
          {
            name = "z";
            inherit (z) src;
          }
        ];
      };
      zellij = {
        enable = true;
      };
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

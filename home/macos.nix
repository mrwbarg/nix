{ config, pkgs, nixpkgs-unstable, home-manager, lib, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";


  nixpkgs.overlays = [
    (final: _prev: {
      unstable = import nixpkgs-unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    })
  ];


  home-manager.users."mauriciobarg" = { config, lib, ... }: {
    home.packages = with pkgs; [
      xplr
      nerdfonts
      fish
      lazygit
      lazydocker
    ];

    home = {
      stateVersion = "${config.system.stateVersion}";
      username = "mauriciobarg";
      homeDirectory = "/Users/mauriciobarg";
    };

    home.file.".walpapers" = {
      recursive = true;
      source = ./walpapers;
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
      lazygit.enable = true;
    };
  };
}

{ config, pkgs, nixpkgs-unstable, home-manager-master, lib, ... }:
{
  imports = [
    home-manager-master.darwinModules.home-manager
    ./system/macos/stylix.nix
    ./system/macos/yabai
    ./system/macos/skhd
    ./system/macos/sketchybar
    ./system/macos/nvchad.nix
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
      nerd-fonts.fira-code
      fish
      lazygit
      lazydocker
      zellij
      fishPlugins.tide
      fishPlugins.z
      btop
    ];

    home = {
      stateVersion = "24.05";
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

      ssh-staging = "aptible ssh --app=homebase-staging";
      ssh-prod = "aptible ssh --app=homebase-two-prod";
      db-prod = "aft rds tunnel -d production";
      db-staging = "aft rds tunnel -d staging";
      db-replica = "aft rds tunnel -d replica";
      wh-prod = "aft rds tunnel -d production";
      wh-redhouse = "aft rds tunnel -d redhouse-prod";
      venv = "source .venv/bin/activate.fish";
    };

    programs = {
      home-manager.enable = true;
      vscode.enable = false;
      alacritty = {
        enable = true;
        settings = {
          terminal.shell = {
            program = "${pkgs.fish}/bin/fish";
          };
          window = {
            opacity = lib.mkForce 0.5;
            blur = true;
          };
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
          direnv hook fish | source
          export DIRENV_LOG_FORMAT=""
          set EDITOR nvim

          export PATH="/opt/aptible-toolbelt/bin:$PATH"
          export PATH="$HOME/.docker/bin:$PATH"
          export GOPATH="$HOME/go"
          export PATH="$GOPATH/bin:$PATH"
          export PATH="/opt/homebrew/bin:$PATH"
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
        enableFishIntegration = true;
        settings = {
          default_shell = "${pkgs.fish}/bin/fish";
        };
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

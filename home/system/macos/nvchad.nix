{ config, pkgs, nixpkgs-unstable, home-manager-master, nvchad4nix, ... }:
{

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


  home-manager.users."mauriciobarg" = { config, lib, ... }: {
    imports = [
      nvchad4nix.homeManagerModule
    ];
    
    home.packages = with pkgs; [
      (pkgs.nvchad.override {
        neovim = pkgs.unstable.neovim;
      })
      stylua
      nixd
      ruff
      deadnix
    ];
  };
}

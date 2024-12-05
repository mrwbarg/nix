
{ config, pkgs, nixpkgs-unstable, home-manager, attrs, lib, nvchad4nix, nvchad-starter,... }:
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


  home-manager.users.mrwbarg = { config, lib, ... }: {
    imports = [
      nvchad4nix.homeManagerModule
    ];
    
    home.packages = [
      (pkgs.nvchad.override {
        extraConfig = nvchad-starter;
      })
    ];
  };
}

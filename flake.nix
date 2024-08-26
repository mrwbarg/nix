{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, ... }@attrs:
    {

      nixosConfigurations.avell = nixpkgs.lib.nixosSystem {
        specialArgs = attrs;
        modules = [
          ./configuration
          ./home
          ./hosts/avell/avell.nix
        ];
      };
    };
}

{
  description = "nixos config flake";

  inputs = {
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel-src = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {url = "github:danth/stylix/release-24.05";};
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel-src, stylix, ... } @ attrs:
    {
      nixosConfigurations.avell = nixpkgs.lib.nixosSystem {
        specialArgs = attrs;
        modules = [
          stylix.nixosModules.stylix
          ./configuration
          ./home
          ./hosts/avell/avell.nix
        ];
      };

    };
}

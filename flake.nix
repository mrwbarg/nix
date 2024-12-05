{
  description = "nixos config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel-src = {
      url = "github:Jas-SinghFSU/HyprPanel";
    };
    stylix = {url = "github:danth/stylix/release-24.05";};
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad-starter = { 
      url = "github:mrwbarg/nvchad-starter";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel-src, stylix, nvchad4nix, nixpkgs-unstable, ... } @ attrs:
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

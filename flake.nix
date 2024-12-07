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
    home-manager-master = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprpanel-src = {
      url = "github:Jas-SinghFSU/HyprPanel";
    };
    stylix = { url = "github:danth/stylix/release-24.05"; };
    stylix-master = { url = "github:danth/stylix"; };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter = {
        url = "github:mrwbarg/nvchad-starter";
        flake = false;
      };
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    ghostscript-fix = {
      url = "github:carlocab/nixpkgs/0b961bd";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , hyprpanel-src
    , stylix
    , nvchad4nix
    , nixpkgs-unstable
    , stylix-master
    , home-manager-master
    , ghostscript-fix
    , darwin
    , ...
    } @ attrs:
    {
      nixosConfigurations.avell = nixpkgs.lib.nixosSystem {
        specialArgs = attrs;
        modules = [
          stylix.nixosModules.stylix
          ./configuration/nixos
          ./home/nixos.nix
          ./hosts/avell/avell.nix
        ];
      };

      darwinConfigurations.work = darwin.lib.darwinSystem {
        specialArgs = attrs;
        modules = [
          stylix-master.darwinModules.stylix
          ./configuration/macos
          ./home/macos.nix
        ];
      };
    };
}

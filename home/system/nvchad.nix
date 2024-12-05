
{ config, pkgs, nixpkgs-unstable, home-manager, attrs, lib, stylix, nvchad4nix, ... }:
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

    programs = {
      nvchad = {
        enable = true;
        neovim = pkgs.unstable.neovim;
        hm-activation = true;  
        extraPlugins = ''return {
          {
            "kdheepak/lazygit.nvim",
            cmd = {
              "LazyGit",
              "LazyGitConfig",  
              "LazyGitCurrentFile",
              "LazyGitFilter",
              "LazyGitFilterCurrentFile",
            },
            dependencies = {
              "nvim-lua/plenary.nvim",
            },
            keys = {
              { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
            }
          },
        }'';
      };
    };
  };
}

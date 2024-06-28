{
  description = "Home Manager configuration of kurumas";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
  };

  outputs = { nixpkgs, home-manager, nixneovimplugins, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}.extend
        nixneovimplugins.overlays.default;
    in
    {
      homeConfigurations.kurumas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home ];
      };
    };
}

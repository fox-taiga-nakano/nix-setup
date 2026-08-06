{
  description = "NixOS-WSL system and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }:
    let
      system = "x86_64-linux";
      userName = "taiga";
    in
    {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/wsl/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userName} = import ./home/${userName}/home.nix;
          }
        ];
      };
    };
}

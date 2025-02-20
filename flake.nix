{
  description = "NixOS configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # <- Nixpkgs unstable branch
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # <- Chaotic Nyx for even more bleeding-edge packages
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs"; # <- Use system packages list where available
    }; # <- Home-manager for managing home configuration
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # <- Add nix-flatpak to manage flatpaks declaratively
    # nur.url = "github:nix-community/nur"; # <- Community packages from NUR (Nix User Repository)
  };
  outputs = { 
    self,
    nixpkgs,
    chaotic,
    nix-flatpak,
    home-manager, 
    # nur, 
    ... }@inputs: {
    nixosConfigurations.hp-15s-du1015tu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./modules/system-configuration.nix
        ./modules/desktop-configuration.nix
        ./modules/flatpak-configuration.nix
        ./modules/hardware-configuration.nix
        ./modules/software-configuration.nix
        ./modules/user-configuration.nix
        chaotic.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
      ];
    };
  };
}

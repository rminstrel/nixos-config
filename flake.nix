{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    
    # # Home-manager for managing home configuration
    # home-manager = {
    #   url = "github:nix-community/home-manager/master";
    #   inputs.nixpkgs.follows = "nixpkgs"; # Use system packages list where available
    # };
    
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add nix-flatpak to manage flatpaks declaratively
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Community packages from NUR (Nix User Repository)
    nur.url = "github:nix-community/nur";

  };

  outputs = { 
    self,
    nixpkgs,
    chaotic,
    nix-flatpak,
    # home-manager, 
    nur, 
    ... 
    }@inputs: {
    nixosConfigurations.hp-15s-du1015tu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./system-configuration.nix
        ./desktop-configuration.nix
        ./flatpak-configuration.nix
        ./hardware-configuration.nix
        ./software-configuration.nix
        ./style-configuration.nix
        ./user-configuration.nix
        chaotic.nixosModules.hp-15s-du1015tu
        nix-flatpak.nixosModules.nix-flatpak
        # inputs.home-manager.nixosModules.hp-15s-du1015tu
      ];
    };
  };
}

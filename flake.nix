{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home-manager for managing home configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Use system packages list where available
    };
    
    # Add your legacylauncher flake input
    legacylauncher.url = "github:rminstrel/llaunch-nixos";
    
    # Community packages; used for Firefox extensions
    nur.url = "github:nix-community/nur";

  };

  outputs = { 
    self,
    nixpkgs, 
    home-manager, 
    nur, 
    legacylauncher, 
    ... 
    }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
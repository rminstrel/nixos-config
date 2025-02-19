{
  description = "Home Manager configuration of rminstrel";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # <- Specify the source of Home Manager and Nixpkgs.
  };

  outputs = { 
    nixpkgs, 
    home-manager,
    ... }: let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    homeConfigurations."rminstrel" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  };
}

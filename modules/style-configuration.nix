{ config, pkgs, lib, ... }:

{
  imports = [ 
    # inputs.home-manager.nixosModules.default
  ];

  # Set Qt styling
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  # Configure which fonts to install
  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  #   nerd-fonts.fira-code
  #   nerd-fonts.liberation
  # ];

  # Install home-manager for declaring home configurations
  # programs.home-manager.enable = true;
  # home-manager = {
  #   extraSpecialArgs = {inherit inputs;};
  #   users = {
  #     "rminstrel" = import ../home-manager/home.nix;
  #   };
  # };
}
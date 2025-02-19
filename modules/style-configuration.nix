{ ... }: {
  imports = [ 
    # inputs.home-manager.nixosModules.default
  ];
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  }; # <- Set Qt styling.
  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  #   nerd-fonts.fira-code
  #   nerd-fonts.liberation
  # ]; # <- Configure which fonts to install.
  # home-manager = {
  #   extraSpecialArgs = {inherit inputs;};
  #   users = {
  #     "rminstrel" = import ../home-manager/home.nix;
  #   }; # <- Import home configuration of user "rminstrel".
  # }; # <- Install home-manager for declaring home configurations.
}
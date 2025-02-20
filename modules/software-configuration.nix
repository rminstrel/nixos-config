{ 
  pkgs,
  inputs,
  ... }: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.nixvim.nixosModules.nixvim
  ];
  programs.firefox.enable = true; # <- Install firefox.
  programs.nixvim.enable = true; # <- Install Nixvim for declarative configuration of Nix integrated with Neovim.
  programs.nano.enable = false; # <- Remove nano because it sucks balls.
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "rminstrel" = import ../home-manager/home.nix;
    }; # <- Import home configuration of user "rminstrel".
  }; # <- Install home-manager for declaring home configurations.
  nixpkgs.config.allowUnfree = true; # <- Allow unfree packages.
  environment.systemPackages = with pkgs; [
    # vim
    # wofi
    # wlogout
    # kitty
    # dunst
    libnotify
    brightnessctl
    # networkmanagerapplet
    # hyprshot
    # grim
    # slurp
    wget
    curl
    git
    nixd
    links2
    wl-clipboard
    wl-clipboard-x11
    wineWowPackages.waylandFull
    winetricks
    steam-run
    kanata-with-cmd
    # xfce.thunar
    shotwell
    vlc
    rhythmbox
    dconf-editor
    gnome-tweaks
    tilix
    pods
  ]; # <- List packages to be installed in system profile.
}
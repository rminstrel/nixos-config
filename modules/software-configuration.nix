{ 
  pkgs,
  inputs,
  ... }: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  # programs.firefox.enable = true; # <- Install firefox.
  programs.nano.enable = false; # <- Remove nano because it sucks balls.
  programs.zsh.enable = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "rminstrel" = import ../home-manager/home.nix;
    }; # <- Import home configuration of user "rminstrel".
  }; # <- Install home-manager for declaring home configurations.
  nixpkgs.config.allowUnfree = true; # <- Allow unfree packages.
  environment.systemPackages = with pkgs; [
    wofi
    wlogout
    kitty
    networkmanagerapplet
    hyprshot
    grim
    slurp
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-vcs-plugin
    xfce.thunar-volman
    hyprpaper
    libnotify
    brightnessctl
    wget
    curl
    git
    nixd
    links2
    wl-clipboard
    wineWowPackages.waylandFull
    winetricks
    steam-run
    kanata-with-cmd
    shotwell
    vlc
    rhythmbox
    kdePackages.okular
    inputs.zen-browser.packages."${system}".default
    # dconf-editor
    # gnome-tweaks
    # tilix
  ]; # <- List packages to be installed in system profile.
}

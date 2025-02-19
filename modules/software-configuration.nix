{ pkgs, inputs, ... }: {
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];
  programs.firefox.enable = true; # <- Install firefox.
  programs.nixvim.enable = true; # <- Install Nixvim for declarative configuration of Nix integrated with Neovim.
  programs.nano.enable = false; # <- Remove nano because it sucks balls.
  programs.bash.blesh.enable = true; # <- Enable ble.sh, a fully featured line editor written in bash.
  nixpkgs.config.allowUnfree = true; # <- Allow unfree packages.
  environment.systemPackages = with pkgs; [
    micro
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
    kdePackages.qt6ct
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
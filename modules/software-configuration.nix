{ pkgs, lib, inputs, ...}:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];
  
  # Install firefox.
  programs.firefox.enable = true;

  # Install Nixvim for declarative configuration of Nix integrated with Neovim
  programs.nixvim.enable = true;

  # Remove nano because it sucks balls
  programs.nano.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    links2
    wl-clipboard
    wl-clipboard-x11
    wineWowPackages.waylandFull
    winetricks
    steam-run
    jre8
    kanata-with-cmd
    kdePackages.qt6ct
    # xfce.thunar
    # adwaita-qt
    # adwaita-qt6
    dconf-editor
    gnome-tweaks
    tilix
    pods
  ];
}
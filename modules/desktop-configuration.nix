{ config, pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
    model = "pc86";
  };
  
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  
  # Enable Hyprland and Waybar for MASSIVE showoff
  # You know what else is massive?
  # LOOOOWWWW TAYYYPER FAYYYYYDEEE!!!!!!!!
  # GET OUT!-
  # programs.hyprland.enable = true;
  # programs.waybar.enable = true;

  # Enable SDDM for Hyprland and other misc. window Managers and DEs
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-contacts
    gnome-text-editor
    gnome-tour
    gnome-music
    gnome-console
    gnome-logs
    gnome-connections
    gnome-software
    geary
    loupe
    totem
    seahorse
    epiphany
  ];
  
  # Configure the XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "gnome";
  };
  
}
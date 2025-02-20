{ 
  pkgs,
  ... }: {
  services.xserver.enable = true; # <- Enable the X11 windowing system.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
    model = "pc86";
  }; # <- Configure keymap in X11.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  }; # <- Enable sound with pipewire.
  services.libinput.enable = true; # <- Enable touchpad support. (enabled default in most desktopManager).
  # Enable Hyprland and Waybar below for MASSIVE showoff. You know what else is MASSIVE? LOW TAPER FADE!!!--- GET OUT!!!---
  # programs.hyprland.enable = true;
  # programs.waybar.enable = true;
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # }; # <- Enable SDDM for Hyprland and other miscellaneous Window Managers and KDE Plasma.
  services.xserver.displayManager.gdm.enable = true; # <- Enable GDM for GNOME.
  services.xserver.desktopManager.gnome.enable = true; # <- Enable the GNOME Desktop Environment.
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
  ]; # <- Define GNOME packages to not be installed because there are better alternatives.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "gnome";
  }; # <- Configure the XDG Portal for GNOME.
}
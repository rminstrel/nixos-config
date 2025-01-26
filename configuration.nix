# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./flatpak.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hp-15s-du1015tu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Set the environment variables 
  environment.sessionVariables = {
  EDITOR = "micro";
  # QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-contacts
    gnome-weather
    gnome-maps
    gnome-clocks
    gnome-text-editor
    gnome-tour
    gnome-music
    gnome-calendar
    gnome-console
    gnome-calculator
    gnome-logs
    gnome-connections
    geary
    loupe
    totem
    seahorse
    epiphany
  ];
  programs.gnome-terminal.enable = false;

  # Set Qt styling
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
    model = "pc86";
  };

  # Configure kanata
  services.kanata = {
    enable = true;
    keyboards = {
      "hp-kbd".config = ''
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(deflayer qwerty
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  esc  a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
  '';
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.rminstrel = {
      isNormalUser = true;
      description = "Alif Al Amin";
      extraGroups = [ "networkmanager" "wheel" "podman" ];
      packages = with pkgs; [
		thunderbird
        fastfetch
        steam
        steam-run
		adwsteamgtk
        # lutris-unwrapped
        gamescope
        mangohud
        libreoffice-fresh
        discord
        obs-studio
        kdePackages.kdenlive
        audacity
        gimp-with-plugins
        inkscape-with-extensions
        ollama
		alpaca
        distrobox
        shotwell
        vlc
        rhythmbox
        qbittorrent
        code-cursor
    ];
  };

  # Install home-manager for declaring home configurations
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "rminstrel" = import ./home-manager/home.nix;
    };
  };

  # getty autologin for rminstrel
  services.getty.autologinUser = "rminstrel";

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
  podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Install and configure flatpak
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    micro
    neovim
    wget
    curl
    git
    links2
    wl-clipboard
    wl-clipboard-x11
    wineWowPackages.waylandFull
    winetricks
    kanata-with-cmd
    # libsForQt5.qt5ct
    kdePackages.qt6ct
    adwaita-qt
    adwaita-qt6
    dconf-editor
    tilix
    pods
  ];

  # Some kernel shenanigans
  boot.kernelModules = [ "fuse" "kvm-intel" "coretemp" "i915" ];
  boot.kernelParams = [ "rw" "rootfstype=ext4" "loglevel=7" "debug" "pcie_aspm=off" "pci=noaer" "mitigations=off" "sysrq_always_enabled=1" "i915.modeset=1" ];
  
  # Fix that damn lid on HP laptops
  systemd.services.hp-keycodes = {
    description = "HP setkeycodes fix";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [ "${pkgs.kbd}/bin/setkeycodes e057 240 e058 240" ];
      RemainAfterExit = "no";
    };
    wantedBy = [ "rescue.target" "multi-user.target" "graphical.target" ];
  };
  
  # Some nix settings to improve performance and build times
  nix.settings = {
    auto-optimise-store = true;
    show-trace = true;
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" "https://nix-community.cachix.org" "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

  # Auto-upgrade the system when necessary
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.11";
    
  # OpenGL shenanigans
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver intel-compute-runtime vulkan-tools aha pciutils wayland-utils glxinfo egl-wayland ];
    # extraPackages32 = with pkgs; [ intel-media-driver intel-compute-runtime vulkan-tools aha pciutils wayland-utils glxinfo egl-wayland ];
  };
  
  # Remove nano because it sucks balls
  programs.nano.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

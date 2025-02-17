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
      inputs.nixvim.nixosModules.nixvim
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
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Hyprland for MASSIVE showoff
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
    gnome-software
    geary
    loupe
    evince
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
  services.pulseaudio.enable = false;
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
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.lifium = {
      isNormalUser = true;
      description = "Alif Al Amin";
      extraGroups = [ "networkmanager" "wheel" "podman" ];
      packages = with pkgs; [
        thunderbird
        fastfetch
        steam
        adwsteamgtk
        lutris-unwrapped
        osu-lazer-bin
        gamescope
        mangohud
        # inputs.legacylauncher.packages.${pkgs.system}.legacylauncher
        libreoffice-fresh
        evince
        discord
        obs-studio
        kdePackages.kdenlive
        shotwell
        vlc
        rhythmbox
        qbittorrent
        vscodium
    ];
  };

  # Configure which fonts to install
  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  #   nerd-fonts.fira-code
  #   nerd-fonts.liberation
  # ];

  # Install home-manager for declaring home configurations
  # programs.home-manager.enable = true;
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "lifium" = import ./home-manager/home.nix;
    };
  };

  # getty autologin for lifium
  services.getty.autologinUser = "lifium";

  # Disable password for sudo (I'm tired of inputting passwords on my own damn computer)
  security.sudo.wheelNeedsPassword = false;

  # Enable podman for containers
  virtualisation = {
   containers.enable = true;
   podman = {
     enable = true;
     dockerCompat = true;
     defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Install and configure flatpak
  services.flatpak.enable = true;
  
    # Configure the XDG Portal for GNOME
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
  ];
    config.common.default = "gnome";
  };

  # Enable and configure folding@home because I'm feeling charitable today :)
  # services.foldingathome = {
  #   enable = true;
  #   user = "rminstrel";
  #   team = 236565;
  #   daemonNiceLevel = -5;
  # };

  # Install firefox.
  programs.firefox.enable = true;

  # Install Nixvim for declarative configuration of Nix integrated with Neovim
  programs.nixvim.enable = true;

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

  # Some kernel shenanigans
  boot.kernelParams = [ "rw" "rootfstype=ext4" "loglevel=7" "debug" "pcie_aspm=off" "pci=noaer" "mitigations=off" "sysrq_always_enabled=1" ];

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
    substituters = [ "https://nix-community.cachix.org" "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

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
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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
  system.stateVersion = "25.05"; # Did you read the comment?

}

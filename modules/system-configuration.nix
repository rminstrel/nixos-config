{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # ./hardware-configuration.nix
    # ./software-configuration.nix
    # ./flatpak-configuration.nix
    # ./desktop-configuration.nix
    # ./style-configuration.nix
    # ./user-configuration.nix
  ];
  # Enable networking via NetworkManager
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

  # Set any system-wide environment variables
  environment.sessionVariables = {
  EDITOR = "micro";
  MOZ_ENABLE_WAYLAND = "1";
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

  # getty autologin for rminstrel
  services.getty.autologinUser = "rminstrel";

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
  
  # Enable and configure folding@home because I'm feeling charitable today :)
  services.foldingathome = {
    enable = true;
    user = "rminstrel";
    team = 236565;
    daemonNiceLevel = -5;
  };

  # Fix that damn lid turing off networking on my HP laptop
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
    substituters = [ "https://nix-community.cachix.org" "https://chaotic-nyx.cachix.org" "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" ];
  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system. Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

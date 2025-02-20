{ 
  pkgs,
  ... }: {
  networking.networkmanager.enable = true; # <- Enable networking via NetworkManager.
  time.timeZone = "Asia/Dhaka"; # <- Set the time zone. 
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
  }; # <- Select internationalisation properties.
  environment.sessionVariables = {
    # FOO = "BAR"; 
  }; # <- Set any system-wide environment variables.
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
  }; # <- Configure kanata for replacing Caps Lock with Esc. (obviously for *vi*)
  services.printing.enable = true; # <- Enable CUPS for printing documents.
  services.getty.autologinUser = "rminstrel"; # <- Set up getty autologin for rminstrel.
  security.sudo.wheelNeedsPassword = false; # <- Disable password for sudo. (I'm tired of inputting passwords on my own damn computer)
  virtualisation = {
   containers.enable = true;
   podman = {
     enable = true;
     dockerCompat = true;
     defaultNetwork.settings.dns_enabled = true;
    };
  }; # <- Enable podman for running containers.
  services.foldingathome = {
    enable = true;
    user = "rminstrel";
    team = 236565;
    daemonNiceLevel = -20;
  }; # <- Enable and configure folding@home because I'm feeling charitable today :)
  systemd.services.hp-keycodes = {
    description = "HP setkeycodes fix";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [ "${pkgs.kbd}/bin/setkeycodes e057 240 e058 240" ];
      RemainAfterExit = "no";
    };
    wantedBy = [ "rescue.target" "multi-user.target" "graphical.target" ];
  }; # <- Fix that damn lid turing off networking on my HP laptop.
  nix.settings = {
    auto-optimise-store = true;
    show-trace = true;
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://nix-community.cachix.org" "https://chaotic-nyx.cachix.org" "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" ];
  }; # <- Some nix settings to improve rebuild performance and reduce rebuild times.
  programs.mtr.enable = true; # <- Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  }; # <- Enable GNUPG for authentication.
  services.openssh.enable = true; # <- Enable the OpenSSH daemon.
  networking.firewall = { 
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  }; # <- Open ports in the firewall.
  networking.firewall.enable = false; # <- Disable the firewall.
  system.stateVersion = "25.05"; # <- This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
}

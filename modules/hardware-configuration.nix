{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Some kernel and initrd shenanigans
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" "i915" "fuse" "coretemp" "rtw88_8821ce" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "rw" "rootfstype=btrfs" "loglevel=7" "quiet" "splash" "pcie_aspm=off" "pci=noaer" "mitigations=off" "sysrq_always_enabled=1" ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  
  # Enable scheduler service
  services.scx = {
    enable = true;
    scheduler = "scx_simple";
  };
  
  # OpenGL shenanigans
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver intel-compute-runtime vulkan-tools aha pciutils wayland-utils glxinfo egl-wayland ];
    # extraPackages32 = with pkgs; [ intel-media-driver intel-compute-runtime vulkan-tools aha pciutils wayland-utils glxinfo egl-wayland ];
  };

  # Define mountpoints for various storage devices
  fileSystems."/" =
    { device = "/dev/vg0/linux_root";
      fsType = "btrfs";
      options = [ "rw" "relatime" "compress=zstd" "subvolid=5" "subvol=/" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/852dfd45-405c-4652-94a9-939500b84ef7";
      fsType = "btrfs";
      options = [ "rw" "relatime" "subvolid=5" "subvol=/" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ED58-2AE9";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home/rminstrel/.config" =
    { device = "/dev/disk/by-uuid/852dfd45-405c-4652-94a9-939500b84ef7";
      fsType = "btrfs";
      options = [ "subvolid=256" "subvol=config" ];
    };

  # Enable swap
  swapDevices =
    [ { device = "/dev/vg0/linux_swap"; }
    ];

  # Define your hostname.
  networking.hostName = "hp-15s-du1015tu"; 

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

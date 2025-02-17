# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" "i915" "fuse" "coretemp" "rtw88_8821ce" ];
  boot.extraModulePackages = [ ];

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

  swapDevices =
    [ { device = "/dev/vg0/linux_swap"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

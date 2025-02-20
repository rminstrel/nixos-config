{ 
  config,
  lib,
  pkgs,
  modulesPath,
  ... }: {
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-intel" "i915" "fuse" "coretemp" "rtw88_8821ce" ];
    extraModulePackages = [ ];
    kernelParams = [ "rw" "rootfstype=btrfs" "loglevel=7" "quiet" "splash" "pcie_aspm=off" "pci=noaer" "mitigations=off" "sysrq_always_enabled=1" ];
    kernelPackages = pkgs.linuxPackages_cachyos; 
  };  # <- Some bootloader, initrd and kernel shenanigans.
  services.scx = {
    enable = true;
    scheduler = "scx_simple";
  }; # <- Enable scheduler service.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver intel-compute-runtime vulkan-tools aha pciutils wayland-utils glxinfo egl-wayland ];
    # extraPackages32 = with pkgs; [ intel-media-driver intel-compute-runtime vulkan-tools aha pciutils wayland-utils glxinfo egl-wayland ];
  }; # <- OpenGL shenanigans.
  fileSystems = {
    "/" = { 
      device = "/dev/vg0/linux_root";
      fsType = "btrfs";
      options = [ "rw" "relatime" "compress=zstd" "subvolid=5" "subvol=/" ];
    };
    "/home" = { 
      device = "/dev/disk/by-uuid/852dfd45-405c-4652-94a9-939500b84ef7";
      fsType = "btrfs";
      options = [ "rw" "relatime" "subvolid=5" "subvol=/" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/ED58-2AE9";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/home/rminstrel/.config" = {
      device = "/dev/disk/by-uuid/852dfd45-405c-4652-94a9-939500b84ef7";
      fsType = "btrfs";
      options = [ "rw" "relatime" "subvolid=256" "subvol=config" ];
    };
  }; # <- Define mountpoints for various storage devices.
  swapDevices =[ 
    { device = "/dev/vg0/linux_swap"; }
  ]; # <- Enable swap
  networking.hostName = "hp-15s-du1015tu"; # <- Define your hostname.
  networking.useDHCP = lib.mkDefault true; # <- Enables DHCP on each ethernet and wireless interface.
  networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

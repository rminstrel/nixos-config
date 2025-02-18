{ config, pkgs, lib, ... }:

let
  # Fetch the latest kernel version from kernel.org by parsing the HTML
  latest_kernel_version = builtins.trimString (builtins.executeCommand "/bin/bash" { inherit pkgs; } ''
    curl -s https://www.kernel.org | grep -oP 'linux-\K[0-9]+\.[0-9]+\.[0-9]+' | head -n 1
  '');
  # Kernel source URL dynamically based on the fetched version
  kernel_source_url = "https://cdn.kernel.org/pub/linux/kernel/v${builtins.substring 0 1 latest_kernel_version}/x/linux-${latest_kernel_version}.tar.xz";

  # Define Linux kernel package
  linuxKernel_cachyos-rminstrel = pkgs.stdenv.mkDerivation {
    pname = "linux-cachyos-rminstrel";
    version = latest_kernel_version;
    src = pkgs.fetchurl {
      url = kernel_source_url;
      sha256 = lib.fakeSha256;
    };

    # Copy the .config file from CachyOS Github repo
    patches = [
      pkgs.runCommand "download-config" {
        buildInputs = [ pkgs.curl ];
      } ''
        curl -L https://raw.githubusercontent.com/CachyOS/linux-cachyos/refs/heads/master/linux-cachyos/config -o $src/.config
      ''
    ];

    # Define unpackPhase to unpack the tarball
    unpackPhase = ''
      tar xf $src
    '';

    # Build the kernel using `make localmodconfig` and `make`
    buildPhase = ''
      cd $src
      # Run `make localmodconfig` to adjust the config based on the system
      make localmodconfig
      # Compile the kernel
      make -j$(nproc)  # Adjust this to your desired number of cores
    '';

    installPhase = ''
      mkdir -p $out
      cp -r $src/.config $out
      cp -r $src/arch/x86/boot/bzImage $out/vmlinuz-cachyos-rminstrel
    '';

    meta = with pkgs.lib; {
      description = "Custom Linux Kernel by CachyOS, modified for use by rminstrel";
      license = licenses.gpl3;
    };
  };
in
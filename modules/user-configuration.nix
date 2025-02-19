{ config, pkgs, lib, ... }: {
  users.users = { 
    rminstrel = {
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
        mangohud
        libreoffice-fresh
        discord
        obs-studio
        kdePackages.kdenlive
        shotwell
        vlc
        rhythmbox
        qbittorrent
        vscodium
      ];
    }; # <- Define user "rminstrel". (me)
    fsmoni = {
      isNormalUser = true;
      description = "Farjana Sharmen";
      packages = with pkgs; [
        thunderbird
        libreoffice-fresh
        shotwell
        vlc
        rhythmbox
      ];
    }; # <- Define user "fsmoni". (my mom)
  }; # <- Define users for the system.
}
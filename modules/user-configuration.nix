{ pkgs, ... }: {
  users.users = { 
    rminstrel = {
      isNormalUser = true;
      description = "Alif Al Amin";
      extraGroups = [ "networkmanager" "wheel" "podman" ];
      packages = with pkgs; [
        thunderbird
        steam
        lutris-unwrapped
        osu-lazer-bin
        mangohud
        libreoffice-fresh
        discord
        obs-studio
        kdePackages.kdenlive
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
        zoom-us
      ];
    }; # <- Define user "fsmoni". (my mom)
  }; # <- Define users for the system.
}
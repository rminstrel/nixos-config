{ lib, ... }: {

services.flatpak = { 
    enable = true;
    remotes = lib.mkOptionDefault [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    update.auto.enable = true;
    uninstallUnmanaged = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "ch.tlaun.TL"
    ];
    overrides = {
      "ch.tlaun.TL".Environment.TL_BOOTSTRAP_OPTIONS = "-Doomsday";
    };
  };
}
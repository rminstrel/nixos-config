{ ... }: {
  services.flatpak = { 
    enable = true; # <- Enables flatpak for installing containerized and isolated applications. (as if NixOS wasn't isolated enough) 
    # remotes = lib.mkOptionDefault [{
    #   name = "flathub";
    #   location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    # }]; # <- Enables default flathub repo, uncomment to customize only.
    update.auto.enable = true; # <- Enable automatic updates.
    uninstallUnmanaged = true; # <- Uninstall unmanaged flatpaks. (those not listed in services.flatpak.packages)
    packages = [
      "com.github.tchx84.Flatseal"
      "ch.tlaun.TL"
    ]; # <- Define packages to be installed.
    overrides = {
      "ch.tlaun.TL".Environment.TL_BOOTSTRAP_OPTIONS = "-Doomsday";
    }; # <- Define overrides globally or on a per-application basis.
  };
}
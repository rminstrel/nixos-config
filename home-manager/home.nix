{ 
  # config,
  pkgs,
  # inputs,
  ... }: {
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
  ];
  home.username = "rminstrel"; # <- Pretty self-explanatory.
  home.homeDirectory = "/home/rminstrel"; # <- Defines home directory for user "rminstrel".
  home.stateVersion = "24.11"; # <- This value determines the Home Manager release that your configuration is compatible with.
  # home.backupFileExtension = "backup";
  home.packages = with pkgs; [
    liberation_ttf
    noto-fonts
    noto-fonts-extra
    noto-fonts-color-emoji
    zsh-autocomplete
    zsh-completions
  ]; # <- The home.packages option allows you to install Nix packages into your home environment.
  home.file = {
  }; # <- Define symlinks to dotfiles and the contents of the dotfiles.
  programs.git = {
    enable = true;
    userName = "Alif Al Amin";
    userEmail = "alifalamin586@gmail.com";
    extraConfig = {
      core.compression = 0;
      http.postBuffer = 2147483647;
    };
  }; # <- Configure git globally.
  programs.zsh = {
	  enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;
    history = {
      append = true;
      extended = true;
      findNoDups = true;
      ignoreAllDups = true;
      save = 2147483647;
      size = 2147483647;
    };
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      edit = "sudo -e ";
      update = "sudo nixos-rebuild switch";
    };
    plugins = [  ];
    initExtra = ''
    eval "$(oh-my-posh init zsh)"
    clear && fastfetch
    '';
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "atomic";
  };
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = { hidden = false; };
      };
    };
    themes = {
      flexoki = let
        transparent = "none";
        light-gray = "#878580";
        dark-gray = "#403e3e";
        white = "#fffcf0";
        black = "#100f0f";
        red = "#af3029";
        light-red = "d14d41";
        green = "#66800b";
        light-green = "#879a39";
        yellow = "#ad8301";
        light-yellow = "#d0a215";
        orange = "#bc5215";
        light-orange = "da702c";
        blue = "#205ea6";
        light-blue = "4385be";
        magenta = "#a02f6f";
        light-magenta = "ce5d97";
        cyan = "#24837b";
        light-cyan = "3aa99f";
      in 
      {
        "ui.menu" = transparent;
        "ui.menu.selected" = { modifiers = [ "reversed" ]; };
        "ui.linenr" = { fg = light-gray; bg = dark-gray; };
        "ui.popup" = { modifiers = [ "reversed" ]; };
        "ui.linenr.selected" = { fg = white; bg = black; modifiers = [ "bold" ]; };
        "ui.selection" = { fg = black; bg = blue; };
        "ui.selection.primary" = { modifiers = [ "reversed" ]; };
        "comment" = { fg = light-gray; };
        "ui.statusline" = { fg = white; bg = dark-gray; };
        "ui.statusline.inactive" = { fg = dark-gray; bg = white; };
        "ui.help" = { fg = dark-gray; bg = white; };
        "ui.cursor" = { modifiers = [ "reversed" ]; };
        "variable" = red;
        "variable.builtin" = orange;
        "constant.numeric" = light-orange;
        "constant" = orange;
        "attributes" = yellow;
        "type" = light-yellow;
        "ui.cursor.match" = { fg = yellow; modifiers = [ "underlined" ]; };
        "string" = green;
        "variable.other.member" = red;
        "constant.character.escape" = cyan;
        "function" = blue;
        "constructor" = light-blue;
        "special" = light-cyan;
        "keyword" = magenta;
        "label" = light-magenta;
        "namespace" = orange;
        "diff.plus" = light-green;
        "diff.delta" = yellow;
        "diff.minus" = light-red;
        "diagnostic" = { modifiers = [ "underlined" ]; };
        "ui.gutter" = { bg = black; };
        "info" = light-blue;
        "hint" = dark-gray;
        "debug" = dark-gray;
        "warning" = yellow;
        "error" = red;
      };
    };
  };
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      backup = true;
      clipboard = "external";
      cursorline = true;
      helpsplit = "vsplit";
      ignorecase = true;
      infobar = true;
      keymenu = true;
      mkparents = true;
      mouse = true;
      ruler = true;
      savecursor = true;
      savehistory = true;
      saveundo = true;
      smartpaste = true;
      softwrap = true;
      tabstospaces = true;
      wordwrap = true;
    };
  };
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos-mini";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = "  ";
      };
      modules = [
        "os"
        "host"
        "kernel"
        "uptime"
        "shell"
        "terminal"
      ];
    };
  };
  home.sessionVariables = {
  }; # <- Define Environment Variables for user session. 
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  }; # <- Configure Qt theming.
  gtk = {
    enable = true;
    theme.name = "adw-gtk3-dark";
    theme.package = pkgs.adw-gtk3;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    cursorTheme.name = "Bibata-Modern-Ice";
    cursorTheme.package = pkgs.bibata-cursors;
    font.name = "Adwaita Sans";
    font.size = 11;
    font.package = pkgs.adwaita-fonts;
  }; # <- Configure GTK theming.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      monospace-font-name = "JetBrainsMono Nerd Font 12";
      document-font-name = "Liberation Serif 12";
      font-name = "Adwaita Sans 11";
    }; # <- Configure GNOME fonts using dconf.
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    }; # <- Configure Virt-manager connections declaratively.
  }; # <- Configure dconf settings.
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Adwaita Sans" ];
      serif = [ "Liberation Serif" ];
    };
  }; # <- Configure fontconfig.
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      monitor = [ "eDP-1, preferred, auto, 1" ];
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";
      exec-once = [
        "waybar & nm-applet & hyprpaper & swaync"
      ];
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(4385beff) rgba(3aa99fee) 45deg";
        "col.inactive_border" = "rgba(205ea6aa) rgba(24837b99) 45deg";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 2;
        active_opacity = 0.85;
        inactive_opacity = 0.75;
        shadow = {
          enabled = true;
          range = 5;
          render_power = 4;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          vibrancy = 0.2;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.25,1,0.3,1"
          "easeInOutCubic,0.6,0.05,0.4,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 8, default"
          "border, 1, 5.5, easeOutQuint"
          "windows, 1, 5, easeOutQuint"
          "windowsIn, 1, 4, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.5, linear, popin 87%"
          "fadeIn, 1, 1.75, almostLinear"
          "fadeOut, 1, 1.5, almostLinear"
          "fade, 1, 3, quick"
          "layers, 1, 4, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.75, almostLinear"
          "fadeLayersOut, 1, 1.5, almostLinear"
          "workspaces, 1, 2, almostLinear, fade"
          "workspacesIn, 1, 1.25, almostLinear, fade"
          "workspacesOut, 1, 2, almostLinear, fade"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };
      gestures.workspace_swipe = true;
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, Delete, exec, wlogout"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, A, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, F11, fullscreen"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        ", Print, exec, hyprshot -m region -o ~/Pictures/Screenshots -z"
        "Shift, Print, exec, hyprshot -m output -o ~/Pictures/Screenshots -z"
        "Alt, Print, exec, hyprshot -m window -o ~/Pictures/Screenshots -z"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 1%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 1%-"
      ];
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  }; # <- Enable Hyprland and configure it using home-manager
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ 
        "/home/rminstrel/Pictures/wallpapers/mountain_view.jpg" 
      ];
      wallpaper = [
        "eDP-1, /home/rminstrel/Pictures/wallpapers/mountain_view.jpg" 
      ];
    };
  };
  services.swaync = {
    enable = true;
    settings = {
      positionX = "center";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
    };
  };
  programs.home-manager.enable = true; # <- Let Home Manager install and manage itself.
}

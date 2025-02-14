{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lifium";
  home.homeDirectory = "/home/lifium";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Insert packages here
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lifium/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Enable Hyprland to configure it using home-manager
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      monitor = [ "eDP-1, preferred, auto, 1" ];

      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      exec-once = [
        "nm-applet &"
        "hyprpaper & dunst"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 4;
        "col.active_border" = "rgba(4385beff) rgba(3aa99fee) 45deg";
        "col.inactive_border" = "rgba(205ea6aa) rgba(24837b99) 45deg";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
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
    		"easeOutExpo,0.19,1,0.22,1"
   			"easeInOutCubic,0.65,0.05,0.36,1"
    		"linear,0,0,1,1"
    		"almostLinear,0.5,0.5,0.75,1.0"
    		"quick,0.15,0,0.1,1"
    		"gentlePop,0.34,1.56,0.64,1"
    		"smoothSlide,0.25,1,0.3,1"
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
  };

  gtk = {
    enable = true;
    font = {
      name = "Cantarell";
      size = 11;
    };
    iconTheme.name = "ePapirus-dark";
    theme.name = "Adwaita-dark";
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

  services.hyprpaper = {
    enable = true;
    extraConfig = { ''
    preload = /home/lifium/Pictures/wallpapers/wallhaven3.jpg
    wallpaper = eDP-1, /home/lifium/Pictures/wallpapers/wallhaven3.jpg
    '' };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

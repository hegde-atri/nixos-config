{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "Enable module";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swappy
      grimblast
      grim
      slurp
      hyprpicker
    ];
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        exec-once=hyprctl setcursor Bibata-Modern-Ice 32
        exec-once=[workspace 8 silent] spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
        exec-once=[workspace 4 silent] ticktick

        monitor=eDP-1,preferred,0x1080,1.0
        monitor=DP-1,1920x1080@120,0x0,1.0
        monitor=HDMI-A-1,preferred,0x0,1.0
        workspace= 1, monitor:DP-1
        workspace= 2, monitor:DP-1
        workspace= 3, monitor:DP-1
        workspace= 4, monitor:DP-1
        workspace= 5, monitor:DP-1
        workspace= 6, monitor:eDP-1
        workspace= 7, monitor:eDP-1
        workspace= 8, monitor:eDP-1
        workspace= 9, monitor:eDP-1
        workspace= 10, monitor:eDP-1
        dwindle {
            pseudotile = yes
            preserve_split = true
            split_width_multiplier = 1.5
            # always split to the right
            force_split = 2
            no_gaps_when_only = true
        }

        gestures {
            workspace_swipe = true
        }
        group{
        col.border_active = 0xa046e0ff
        col.border_inactive = 0x46afe0ff
        groupbar {
            enabled = true
            font_family = JetbrainsMono
            render_titles = true
            height = 2
            text_color = 0xff000000
            col.active = 0x9329f0ff
            col.inactive = 0x29b1f0ff
        }
        }
        input {
            kb_layout = gb
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =
            numlock_by_default = true

            follow_mouse = 2

            touchpad {
                natural_scroll = no
            }

            sensitivity = 0.1 # -1.0 - 1.0, 0 means no modification.
            accel_profile = flat
        }
        general {
            gaps_in = 0
            gaps_out = 0
            border_size = 1
            col.active_border = rgba(938aa9ff) rgba(7aa89fff) 45deg
            col.inactive_border = rgba(1a1a1aff)
            layout = dwindle
        }

        decoration {
            rounding = 2
            blur {
            enabled = true
            size = 4
            passes = 1
            new_optimizations = true
            }
            drop_shadow = yes
            shadow_range = 0
        }
        animations {
            enabled = yes
            bezier=linear,0,0,1,1
            bezier=overshot,0.05,0.9,0.1,1.1
            bezier=easeOut,0.25, 1, 0.5, 1
            animation=windows,1,3,easeOut,slide
            # animation=borderangle,1,100,linear,loop
            animation=workspaces,1,3,easeOut,slidefade
            animation=fade,1,5,default
            #bezier = myBezier, 0.05, 0.9, 0.1, 1.05
            # animation=windows,1,5,default
            # animation=border,1,5,default
            # animation=fadeIn,1,5,default
            # animation=workspaces,1,4,default
            # animation = windows, 1, 7, myBezier
            # animation=windowsOut, 1, 7, overshot
            # animation = border, 1, 10, default
        }

        # --- Window Rules ---
        # windowrule=workspace 4 silent, ticktick
        windowrule=workspace 8 silent, spotify
        windowrule=workspace 9 silent, webcord
        # --- Firefox Picture in Picture ---
        windowrulev2 = float,class:^(firefox)$,title:^(Picture-in-Picture)$
        windowrulev2 = pin,class:^(firefox)$,title:^(Picture-in-Picture)$
        windowrulev2 = float,class:^(firefox)$,title:^()$
        windowrulev2 = float,class:(kitty),title:(kitty)
        # --- Flameshot fix ---
        windowrulev2=move 0 0,title:^(flameshot)
        # windowrulev2=nofullscreenrequest,title:^(flameshot)
        # --- Opacity ---
        windowrule = opacity 1.0 0.8, foot
        # Swayidle inhibit
        windowrulev2 = idleinhibit always, fullscreen:1

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, return, exec, footclient
        bind = $mainMod, U, exec, firefox
        bind = $mainMod, Y, exec, emacsclient -nc
        bind = $mainMod, O, exec, hyprlock
        bind = $mainMod, P, exec, wlogout
        # --- eww bar ---
        bind = $mainMod, B, exec, eww open --toggle bar0
        # bind = $mainMod SHIFT, B, exec, eww open --toggle bar1
        bind = $mainMod, N, exec, eww open --toggle control_centre
        bind = $mainMod SHIFT, B, exec, pkill waybar || waybar
        # --- wofi things ---
        bind = $mainMod, space, exec, pkill fuzzel || fuzzel
        bind = $mainMod, W, exec, pkill set-bg || ~/.local/bin/custom/set-bg
        bind = $mainMod, E, exec, pkill wofi-emoji || wofi-emoji

        # Util
        bind = $mainMod SHIFT, C, exec, hyprpicker -ar

        # Window manager things
        bind = $mainMod, Q, killactive
        bind = $mainMod SHIFT, Q, exec, kill $(hyprctl activewindow | rg "pid" | rg -oe '[0-9]+')
        bind = $mainMod ALT, Q, exit
        bind = $mainMod, V, togglefloating
        bind = $mainMod, X, pin
        bind = $mainMod, F, fullscreen
        bind = $mainMod SHIFT, F, fullscreenstate, 0, 1
        bind = $mainMod, T, pseudo, # dwindle
        bind = $mainMod, R, togglesplit, # dwindle
        bind = $mainMod, G, togglegroup,
        # bind = ALT, TAB, changegroupactive, f
        bind = ALT SHIFT, TAB, changegroupactive, b
        # Enable powersave mode
        bind = ALT SHIFT, P, exec, ~/.config/hypr/scripts/toggle_animations.sh

        # Dynamic gaps
        binde = $mainMod, equal, exec, ~/.cargo/bin/hypr-helper gaps increase
        binde = $mainMod, minus, exec, ~/.cargo/bin/hypr-helper gaps decrease
        binde = $mainMod SHIFT, equal, exec, ~/.cargo/bin/hypr-helper gaps reset

        bind = SUPER_SHIFT,S,movetoworkspace,special
        bind = SUPER,S,togglespecialworkspace

        bind = ,F1,pass,^(com\.obsproject\.Studio)$
        bind = ,F2,pass,^(com\.obsproject\.Studio)$
        bind = ,F3,pass,^(com\.obsproject\.Studio)$
        bind = ,F4,pass,^(com\.obsproject\.Studio)$

        # Move focus and move windows
        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d
        bind = $mainMod SHIFT, h, movewindow, l
        bind = $mainMod SHIFT, l, movewindow, r
        bind = $mainMod SHIFT, k, movewindow, u
        bind = $mainMod SHIFT, j, movewindow, d

        # Resize window
        binde = $mainMod CTRL, h, resizeactive, -10 0 binde = $mainMod CTRL, l, resizeactive, 10 0 binde = $mainMod CTRL, k, resizeactive, 0 -10
        binde = $mainMod CTRL, j, resizeactive, 0 10

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # windows workspace navigation like keymaps
        bind = $mainMod CTRL, right, workspace, e+1
        bind = $mainMod CTRL, left, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # --- Volume keys ---
        bindel=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindel=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle

        # --- Media keys ---
        bind = , XF86AudioPlay, exec, playerctl play-pause
        bind = , XF86AudioNext, exec, playerctl next
        bind = , XF86AudioPrev, exec, playerctl previous
        # bind = , XF86AudioStop, exec, playerctl play-pause

        # --- Brightness keys ---
        binde=, XF86MonBrightnessUp, exec, brightnessctl s +10 -q
        binde=, XF86MonBrightnessDown, exec, brightnessctl s 10- -q

        # --- Misc ---
        bind=, Print, exec, grimblast save area - | wl-copy
        bind=$mainMod, Print, exec, grimblast save active - | wl-copy
        # bind=$mainMod, Print, exec, grimshot save active - | wl-copy
        bind=$mainMod SHIFT, Print, exec, grim -g "$(slurp)" - | swappy -f -

        misc {
            always_follow_on_dnd = false
            disable_hyprland_logo = true
            enable_swallow = true
            swallow_regex = foot
        }
      '';
    };
  };
}

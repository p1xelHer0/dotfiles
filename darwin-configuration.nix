{ config, lib, pkgs, ... }:

let homeDir = builtins.getEnv ("HOME");

in with pkgs.stdenv;
with lib; {
  system.stateVersion = 4;
  environment.systemPackages = [ pkgs.zsh pkgs.lorri ];

  # darwin-rebuild switch -I darwin-config=$HOME/dotfiles/darwin-configuration.nix
  environment.darwinConfig = "${homeDir}/dotfiles/darwin-configuration.nix";

  programs.bash.enable = false;
  programs.zsh.enable = true;

  environment.shells = [ pkgs.zsh ];

  users.users.pontusnagy.shell = pkgs.zsh;
  users.users.pontusnagy.home = homeDir;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = "0.0";
      autohide-time-modifier = "0.0";
      minimize-to-application = true;
      mru-spaces = false;
      orientation = "bottom";
      show-recents = false;
      tilesize = 64;
    };

    screencapture.location = "${homeDir}/screenshots";

    finder = {
      AppleShowAllExtensions = true;
      CreateDesktop = true;
      FXEnableExtensionChangeWarning = false;
      QuitMenuItem = true;
      _FXShowPosixPathInTitle = true;
    };

    trackpad = {
      ActuationStrength = 0;
      Clicking = true;
      FirstClickThreshold = 2;
      SecondClickThreshold = 2;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
    };

    NSGlobalDomain = {
      AppleFontSmoothing = 0;
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSScrollAnimationEnabled = false;
      NSTableViewDefaultSizeMode = 1;
      NSWindowResizeTime = "0.0";
      _HIHideMenuBar = true;
    };
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain."com.apple.springing.delay" = "0.0";
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    NSGlobalDomain."com.apple.trackpad.scaling" = "0.55";
    NSGlobalDomain."com.apple.springing.enabled" = false;
    NSGlobalDomain."com.apple.sound.beep.volume" = "0.4723665";
    NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
  };

  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" =
    "/System/Library/Sounds/Frog.aiff";

  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - return : alacritty --config-file=$HOME/.config/alacritty/live.yml

      # focus window
      cmd - h : yabai -m window --focus west
      cmd - j : yabai -m window --focus south
      cmd - k : yabai -m window --focus north
      cmd - l : yabai -m window --focus east

      # swap window
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      # move window
      shift + cmd - h : yabai -m window --warp west
      shift + cmd - j : yabai -m window --warp south
      shift + cmd - k : yabai -m window --warp north
      shift + cmd - l : yabai -m window --warp east

      # balance size of windows
      shift + alt - 0 : yabai -m space --balance

      # make floating window fill screen
      shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

      # make floating window fill left-half of screen
      shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1

      # make floating window fill right-half of screen
      shift + alt - right  : yabai -m window --grid 1:2:1:0:1:1

      # create desktop, move window and follow focus
      shift + cmd - n : yabai -m space --create;\
                        id=$(yabai -m query --displays --display | grep "spaces");\
                        yabai -m window --space $(echo ''${id:10:''${#id}-10});\
                        yabai -m space --focus $(echo ''${id:10:''${#id}-10})

      # create desktop and follow focus
      cmd + alt - n : yabai -m space --create;\
                      id=$(yabai -m query --displays --display | grep "spaces");\
                      yabai -m space --focus $(echo ''${id:10:''${#id}-10})

      # destroy desktop
      cmd + alt - w : yabai -m space --destroy

      # fast focus desktop
      cmd + alt - x : yabai -m space --focus last
      cmd + alt - z : yabai -m space --focus prev
      cmd + alt - c : yabai -m space --focus next
      cmd + alt - 1 : yabai -m space --focus 1
      cmd + alt - 2 : yabai -m space --focus 2
      cmd + alt - 3 : yabai -m space --focus 3
      cmd + alt - 4 : yabai -m space --focus 4
      cmd + alt - 5 : yabai -m space --focus 5
      cmd + alt - 6 : yabai -m space --focus 6
      cmd + alt - 7 : yabai -m space --focus 7
      cmd + alt - 8 : yabai -m space --focus 8
      cmd + alt - 9 : yabai -m space --focus 9
      cmd + alt - 0 : yabai -m space --focus 10

      # send window to desktop and follow focus
      shift + cmd - x : yabai -m window --space last; yabai -m space --focus last
      shift + cmd - z : yabai -m window --space prev; yabai -m space --focus prev
      shift + cmd - c : yabai -m window --space next; yabai -m space --focus next
      shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
      shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
      shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
      shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
      shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5
      shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6
      shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7
      shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8
      shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9
      shift + cmd - 0 : yabai -m window --space 10; yabai -m space --focus 10

      # focus monitor
      ctrl + alt - x  : yabai -m display --focus last
      ctrl + alt - z  : yabai -m display --focus prev
      ctrl + alt - c  : yabai -m display --focus next
      ctrl + alt - 1  : yabai -m display --focus 1
      ctrl + alt - 2  : yabai -m display --focus 2
      ctrl + alt - 3  : yabai -m display --focus 3

      # send window to monitor and follow focus
      ctrl + cmd - x  : yabai -m window --display last; yabai -m display --focus last
      ctrl + cmd - z  : yabai -m window --display prev; yabai -m display --focus prev
      ctrl + cmd - c  : yabai -m window --display next; yabai -m display --focus next
      ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
      ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
      ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3

      # move window
      shift + ctrl - a : yabai -m window --move rel:-20:0
      shift + ctrl - s : yabai -m window --move rel:0:20
      shift + ctrl - w : yabai -m window --move rel:0:-20
      shift + ctrl - d : yabai -m window --move rel:20:0

      # increase window size
      shift + alt - a : yabai -m window --resize left:-20:0
      shift + alt - s : yabai -m window --resize bottom:0:20
      shift + alt - w : yabai -m window --resize top:0:-20
      shift + alt - d : yabai -m window --resize right:20:0

      # decrease window size
      shift + cmd - a : yabai -m window --resize left:20:0
      shift + cmd - s : yabai -m window --resize bottom:0:-20
      shift + cmd - w : yabai -m window --resize top:0:20
      shift + cmd - d : yabai -m window --resize right:-20:0

      # set insertion point in focused container
      ctrl + alt - h : yabai -m window --insert west
      ctrl + alt - j : yabai -m window --insert south
      ctrl + alt - k : yabai -m window --insert north
      ctrl + alt - l : yabai -m window --insert east

      # rotate tree
      alt - r : yabai -m space --rotate 90

      # mirror tree y-axis
      alt - y : yabai -m space --mirror y-axis

      # mirror tree x-axis
      alt - x : yabai -m space --mirror x-axis

      # toggle desktop offset
      alt - a : yabai -m space --toggle padding; yabai -m space --toggle gap

      # toggle window parent zoom
      alt - d : yabai -m window --toggle zoom-parent

      # toggle window fullscreen zoom
      alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window native fullscreen
      shift + cmd - f : yabai -m window --toggle native-fullscreen

      # toggle window border
      shift + cmd - b : yabai -m window --toggle border

      # toggle window split type
      alt - e : yabai -m window --toggle split

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
                yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky
      alt - s : yabai -m window --toggle sticky

      # toggle sticky, float and resize to picture-in-picture size
      # alt - p : yabai -m window --toggle sticky;\
      #           yabai -m window --grid 5:5:4:0:1:1

      # change layout of desktop
      ctrl + alt - a : yabai -m space --layout bsp
      ctrl + alt - d : yabai -m space --layout float

      # }}}
    '';
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_opacity = "off";
      window_opacity_duration = "0.0";
      window_border = "off";
      active_window_border_topmost = "off";
      window_topmost = "on";
      window_shadow = "float";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 35;
      bottom_padding = 15;
      left_padding = 15;
      right_padding = 15;
      window_gap = 15;
    };

    extraConfig = ''
      yabai -m rule --add app='System Preferences' manage=off
      yabai -m rule --add app='licecap' manage=off
    '';
  };

  # nighthook
  # if there's no 'live.yml' alacritty config initially,
  # copy it from the default config
  environment.extraInit = ''
    test -f ${homeDir}/.config/alacritty/live.yml || \
      cp ${homeDir}/.config/alacritty/alacritty.yml \
      ${homeDir}/.config/alacritty/live.yml
  '';

  launchd.user.agents = {
    # copied verbatim from
    # https://github.com/iknow/nix-channel/blob/7bf3584e0bef531836050b60a9bbd29024a1af81/darwin-modules/lorri.nix
    "lorri" = {
      serviceConfig = {
        WorkingDirectory = (builtins.getEnv "HOME");
        EnvironmentVariables = { };
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/var/tmp/lorri.log";
        StandardErrorPath = "/var/tmp/lorri.log";
      };
      script = ''
        source ${config.system.build.setEnvironment}
        exec ${pkgs.lorri}/bin/lorri daemon
      '';
    };

    "nighthook" = {
      serviceConfig = {
        Label = "ae.cmacr.nighthook";
        WatchPaths =
          [ "${homeDir}/Library/Preferences/.GlobalPreferences.plist" ];
        EnvironmentVariables = {
          PATH = (replaceStrings [ "$HOME" ] [ homeDir ]
            config.environment.systemPath);
        };
        ProgramArguments = [
          "${pkgs.writeShellScript "nighthook-action" ''
            if defaults read -g AppleInterfaceStyle &>/dev/null ; then
              MODE="dark"
            else
              MODE="light"
            fi

            spacebarSwitchTheme() {
              if pgrep -q spacebar; then
                if [[  $MODE == "dark"  ]]; then
                  spacebar -m config background_color 0xff202020
                  spacebar -m config foreground_color 0xffa8a8a8
                elif [[  $MODE == "light"  ]]; then
                  spacebar -m config background_color 0xffeee8d5
                  spacebar -m config foreground_color 0xff073642
                fi
              fi
            }

            alacrittySwitchTheme() {
              DIR=/Users/pontusnagy/.config/alacritty
              if [[  $MODE == "dark"  ]]; then
                cp -f $DIR/alacritty.yml $DIR/live.yml
              elif [[  $MODE == "light"  ]]; then
                cp -f $DIR/light.yml $DIR/live.yml
              fi
            }

            yabaiSwitchTheme() {
              if [[  $MODE == "dark"  ]]; then
                yabai -m config active_window_border_color "0xff5c7e81"
                yabai -m config normal_window_border_color "0xff505050"
                yabai -m config insert_window_border_color "0xffd75f5f"
              elif [[  $MODE == "light"  ]]; then
                yabai -m config active_window_border_color "0xff2aa198"
                yabai -m config normal_window_border_color "0xff839496 "
                yabai -m config insert_window_border_color "0xffdc322f"
              fi
            }

            spacebarSwitchTheme $@
            alacrittySwitchTheme $@
            yabaiSwitchTheme $@
          ''}"
        ];
      };
    };
  };
}

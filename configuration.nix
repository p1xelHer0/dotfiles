{ config, pkgs, lib, ... }:
let
  homeDir = builtins.getEnv ("HOME");
  user = builtins.getEnv ("USER");
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # https://github.com/NixOS/nix/issues/7273
    auto-optimise-store = false;

    # Recommended when using `direnv` etc.
    keep-derivations = true;
    keep-outputs = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  environment.systemPackages = with pkgs; [
    pam-reattach
    zsh
  ];

  environment.darwinConfig = "/Users/p1xelher0/dotfiles/configuration.nix";

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  users.users.p1xelher0 = {
    shell = pkgs.zsh;
    home = /Users/p1xelher0;
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      minimize-to-application = true;
      mru-spaces = false;
      orientation = "bottom";
      show-recents = false;
      tilesize = 64;
    };

    screencapture.location = "/Users/p1xelher0/Pictures/screenshots";

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
      NSWindowResizeTime = 0.0;
      _HIHideMenuBar = true;
    };
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain."com.apple.springing.delay" = 0.0;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    NSGlobalDomain."com.apple.trackpad.scaling" = 0.55;
    NSGlobalDomain."com.apple.springing.enabled" = false;
    NSGlobalDomain."com.apple.sound.beep.volume" = 0.4723665;
    NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
  };

  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" =
    "/System/Library/Sounds/Frog.aiff";

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  fonts = {
    fontDir = {
      enable = true;
    };
  };

  homebrew = {
    enable = true;
    global.brewfile = true;

    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "DevCleaner/devcleaner"
      "fsouza/prettierd"
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-versions"
      "homebrew/core"
      "osx-cross/arm"
      "osx-cross/avr"
      "qmk/qmk"
    ];

    brews = [
      "mas"
      "fsouza/prettierd/prettierd"
      "qmk/qmk/qmk"

      # QMK dependencies
      # https://github.com/qmk/qmk_firmware/blob/master/util/install/macos.sh
      "avr-gcc@8"
      "arm-gcc-bin@8"
    ];

    casks = [
      "alt-tab"
      "appcleaner"
      "devcleaner"
      "discord"
      "firefox"
      "google-chrome"
      "gpg-suite-no-mail"
      "grandperspective"
      "hammerspoon"
      "karabiner-elements"
      "keycastr"
      "linearmouse"
      "mactex-no-gui"
      "obs"
      "obsidian"
      "retroarch-metal"
      "secretive"
      "spotify"
      "visual-studio-code"
      "vlc"
    ];

    masApps = {
      "Key Codes" = 414568915;
      Developer = 640199958;
      Lungo = 1263070803;
      Messenger = 1480068668;
      Slack = 803453959;
      Telegram = 747648890;
      Typesy = 1059295091;
      Xcode = 497799835;
    };
  };

  # system.activationScripts.postUserActivation.text = ''
  #   echo "Upgrading Homebrew Casks..."
  #   ${config.homebrew.brewPrefix}/brew upgrade --casks \
  #   ${pkgs.lib.concatStringsSep " " config.homebrew.casks}
  # '';

  services.yabai = {
    enable = false;
    package = pkgs.yabai;

    # Had no luck with this, run:
    # sudo yabai --install-sa after installation
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";

      window_placement = "second_child";

      window_topmost = "off";
      window_shadow = "off";

      window_opacity = "on";
      window_opacity_duration = "0.0";
      active_window_opacity = "1";
      normal_window_opacity = "0.9";

      window_border = "on";
      window_border_width = "6";

      # colors also set in nighthook
      active_window_border_color = "0xff9da488";
      normal_window_border_color = "0xff30302c";

      split_ratio = "0.50";
      auto_balance = "off";

      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";

      layout = "bsp";
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      window_gap = 8;

      external_bar = "all:26:0";
    };

    extraConfig = ''
      yabai -m rule --add app='Mullvad VPN' manage=off
      yabai -m rule --add app='System Preferences' manage=off
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # open alacritty
      cmd - return : open -n $HOME/.nix-profile/Applications/Alacritty.app --args --config-file $HOME/.config/alacritty/live.yml

      # swap dark/light appearance
      # alt - return : osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
      alt - return : osascript -e 'choose color'

      # # focus window
      # cmd - h : yabai -m window --focus west
      # cmd - j : yabai -m window --focus south
      # cmd - k : yabai -m window --focus north
      # cmd - l : yabai -m window --focus east
      #
      # # move window
      # shift + cmd - h : yabai -m window --warp west
      # shift + cmd - j : yabai -m window --warp south
      # shift + cmd - k : yabai -m window --warp north
      # shift + cmd - l : yabai -m window --warp east
      #
      # # swap window
      # ctrl + cmd - h : yabai -m window --swap west
      # ctrl + cmd - j  : yabai -m window --swap south
      # ctrl + cmd - k : yabai -m window --swap north
      # ctrl + cmd - l : yabai -m window --swap east
      #
      # # balance size of windows
      # shift + cmd - 0 : yabai -m space --balance
      #
      # # increase window size
      # shift + alt - a : yabai -m window --resize left:-20:0
      # shift + alt - s : yabai -m window --resize bottom:0:20
      # shift + alt - w : yabai -m window --resize top:0:-20
      # shift + alt - d : yabai -m window --resize right:20:0
      #
      # # decrease window size
      # shift + cmd - a : yabai -m window --resize left:20:0
      # shift + cmd - s : yabai -m window --resize bottom:0:-20
      # shift + cmd - w : yabai -m window --resize top:0:20
      # shift + cmd - d : yabai -m window --resize right:-20:0
      #
      # # create desktop
      # shift + cmd - n : yabai -m space --create
      #
      # # destroy desktop
      # ctrl + cmd - w : yabai -m space --destroy
      #
      # # fast focus desktop
      # ctrl + cmd - space : yabai -m space --focus last
      # ctrl - right : yabai -m space --focus next
      # ctrl - left : yabai -m space --focus prev
      # ctrl - f1 : yabai -m space --focus 1
      # ctrl - f2 : yabai -m space --focus 2
      # ctrl - f3 : yabai -m space --focus 3
      # ctrl - f4 : yabai -m space --focus 4
      # ctrl - f5 : yabai -m space --focus 5
      # ctrl - f6 : yabai -m space --focus 6
      # ctrl - f7 : yabai -m space --focus 7
      # ctrl - f8 : yabai -m space --focus 8
      # ctrl - f9 : yabai -m space --focus 9
      # ctrl - f10 : yabai -m space --focus 10
      # ctrl - f11 : yabai -m space --focus 11
      # ctrl - f12 : yabai -m space --focus 12
      #
      # # send window to desktop and follow focus
      # shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
      # shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
      # shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
      # shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
      # shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5
      # shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6
      # shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7
      # shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8
      # shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9
      # shift + cmd - 0 : yabai -m window --space 10; yabai -m space --focus 10
      #
      # # focus monitor
      # # ctrl + cmd - e  : yabai -m display --focus 1
      # # ctrl + cmd - r  : yabai -m display --focus 2
      #
      # # send window to monitor and follow focus
      # # ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
      # # ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
      # # ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3
      #
      # # rotate tree
      # alt - r : yabai -m space --rotate 90
      #
      # # mirror tree y-axis
      # alt - y : yabai -m space --mirror y-axis
      #
      # # mirror tree x-axis
      # alt - x : yabai -m space --mirror x-axis
      #
      # # toggle desktop offset
      # alt - a : yabai -m space --toggle padding; yabai -m space --toggle gap
      #
      # # toggle window parent zoom
      # alt - d : yabai -m window --toggle zoom-parent
      #
      # # toggle window fullscreen zoom
      # alt - f : yabai -m window --toggle zoom-fullscreen
      #
      # # toggle window border
      # alt - b : yabai -m window --toggle border
      #
      # # toggle window split type
      # alt - e : yabai -m window --toggle split
      #
      # # float / unfloat window and center on screen
      # alt - t : yabai -m window --toggle float;\
      #           yabai -m window --grid 4:4:1:1:2:2
    '';

  };

  services.spacebar = {
    enable = false;
    package = pkgs.spacebar;
    config = {
      title = "on";
      spaces = "on";
      clock = "on";
      power = "on";

      height = 26;
      padding_left = 8;
      padding_right = 8;
      spacing_left = 12;
      spacing_right = 12;

      text_font = ''"JetBrainsMonoNL Nerd Font Mono:Medium:12.0"'';
      icon_font = ''"JetBrainsMonoNL Nerd Font Mono:Medium:12.0"'';

      right_shell = "on";
      right_shell_command = "whoami";

      # colors also set in nighthook
      background_color = "0xff080807";
      foreground_color = "0xffb5a488";
      space_icon_color = "0xff9da488";
    };
  };

  # nighthook
  # if there's no 'live.yml' alacritty config initially,
  # copy it from the default config
  environment.extraInit = ''
    test -f ~/.config/alacritty/live.yml || \
      cp ~/.config/alacritty/alacritty.yml \
      ~/.config/alacritty/live.yml
  '';

  launchd.user.agents = {
    #   "lorri" = {
    #     serviceConfig = {
    #       WorkingDirectory = (builtins.getEnv "HOME");
    #       EnvironmentVariables = { };
    #       KeepAlive = true;
    #       RunAtLoad = true;
    #       StandardOutPath = "/var/tmp/lorri.log";
    #       StandardErrorPath = "/var/tmp/lorri.log";
    #     };
    #     script = ''
    #       source ${config.system.build.setEnvironment}
    #       exec ${pkgs.lorri}/bin/lorri daemon
    #     '';
    #   };

    "nighthook" = {
      serviceConfig = {
        Label = "nighthook";
        WatchPaths =
          [ "/Users/p1xelher0/Library/Preferences/.GlobalPreferences.plist" ];
        EnvironmentVariables = {
          PATH = (builtins.replaceStrings [ "$HOME" ] [ "/Users/p1xelher0" ] config.environment.systemPath);
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
                  spacebar -m config background_color 0xff080807
                  spacebar -m config foreground_color 0xffb5a488
                  spacebar -m config space_icon_color 0xff9da488
                elif [[  $MODE == "light"  ]]; then
                  spacebar -m config background_color 0xfffaeed7
                  spacebar -m config foreground_color 0xff080807
                  spacebar -m config space_icon_color 0xff9da488
                fi
              fi
            }

            alacrittySwitchTheme() {
              DIR=/Users/p1xelher0/.config/alacritty
              if [[  $MODE == "dark"  ]]; then
                cp -f $DIR/dark.yml $DIR/live.yml
              elif [[  $MODE == "light"  ]]; then
                cp -f $DIR/light.yml $DIR/live.yml
              fi
            }

            switchTheme() {
              FILE=~/.config/.theme
              echo $MODE > $FILE
            }

            yabaiSwitchTheme() {
              if [[  $MODE == "dark"  ]]; then
                yabai -m config active_window_border_color "0xff9da488"
                yabai -m config normal_window_border_color "0xff30302c"
              elif [[  $MODE == "light"  ]]; then
                yabai -m config active_window_border_color "0xff9da488"
                yabai -m config normal_window_border_color "0xffc9bfad"
              fi
            }

            # spacebarSwitchTheme $@
            alacrittySwitchTheme $@
            # switchTheme $@
            # yabaiSwitchTheme $@
          ''}"
        ];
      };
    };
  };
}

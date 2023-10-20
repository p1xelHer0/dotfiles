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

  environment.darwinConfig = "/Users/pontusnagy/dotfiles/work.nix";

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  users.users.pontusnagy = {
    shell = pkgs.zsh;
    home = /Users/pontusnagy;
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

    screencapture.location = "/Users/pontusnagy/Pictures/screenshots";

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
    ];

    brews = [
      "fsouza/prettierd/prettierd"
      "mas"
      "ncurses"
    ];

    casks = [
      "alt-tab"
      "appcleaner"
      "devcleaner"
      "google-chrome"
      "grandperspective"
      "hammerspoon"
      "karabiner-elements"
      "linearmouse"
      "obsidian"
      "orbstack"
      "secretive"
      "tableplus"
      "visual-studio-code"
    ];

    masApps = {
      Developer = 640199958;
      Xcode = 497799835;
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
    "nighthook" = {
      serviceConfig = {
        Label = "nighthook";
        WatchPaths =
          [ "/Users/pontusnagy/Library/Preferences/.GlobalPreferences.plist" ];
        EnvironmentVariables = {
          PATH = (builtins.replaceStrings [ "$HOME" ] [ "/Users/pontusnagy" ] config.environment.systemPath);
        };
        ProgramArguments = [
          "${pkgs.writeShellScript "nighthook-action" ''
            if defaults read -g AppleInterfaceStyle &>/dev/null ; then
              MODE="dark"
            else
              MODE="light"
            fi

            alacrittySwitchTheme() {
              DIR=/Users/pontusnagy/.config/alacritty
              if [[  $MODE == "dark"  ]]; then
                cp -f $DIR/dark.yml $DIR/live.yml
              elif [[  $MODE == "light"  ]]; then
                cp -f $DIR/light.yml $DIR/live.yml
              fi
            }

            alacrittySwitchTheme $@
          ''}"
        ];
      };
    };
  };
}

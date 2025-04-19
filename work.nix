{ config, pkgs, lib, ... }:
{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  ids.gids.nixbld = 350;

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

  environment.systemPackages = with pkgs; [
    pam-reattach
    zsh
  ];

  environment.darwinConfig = "/Users/pontus.nagy/dotfiles/work.nix";

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  users.users."pontus.nagy" = {
    shell = pkgs.zsh;
    home = /Users/pontus.nagy;
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

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

    screencapture.location = "/Users/pontus.nagy/Pictures/screenshots";

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
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

  homebrew = {
    enable = true;
    global.brewfile = true;

    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };

    taps = [
      "DevCleaner/devcleaner"
      # "fsouza/prettierd"
      "homebrew/bundle"
      # "homebrew/cask"
      # "homebrew/cask-versions"
      # "homebrew/core"
    ];

    brews = [
      # "fsouza/prettierd/prettierd"
      # "mas"
      # "ncurses"
    ];

    casks = [
      # "alt-tab"
      "appcleaner"
      "devcleaner"
      # "google-chrome"
      "firefox"
      "grandperspective"
      "hammerspoon"
      "karabiner-elements"
      # "keycastr"
      "linearmouse"
      "mockoon"
      "ngrok"
      "notion"
      "obsidian"
      "orbstack"
      "secretive"
      "tableplus"
      "visual-studio-code"
      "zed"
    ];

    masApps = {
      # Developer = 640199958;
      # Xcode = 497799835;
    };
  };

  # nighthook
  launchd.user.agents = {
    "nighthook" = {
      serviceConfig = {
        Label = "nighthook";
        WatchPaths =
          [ "/Users/pontus.nagy/Library/Preferences/.GlobalPreferences.plist" ];
        EnvironmentVariables = {
          PATH = (builtins.replaceStrings [ "$HOME" ] [ "/Users/pontus.nagy" ] config.environment.systemPath);
        };
        ProgramArguments = [
          "${pkgs.writeShellScript "nighthook-action" ''
            if defaults read -g AppleInterfaceStyle &>/dev/null ; then
              MODE="dark"
            else
              MODE="light"
            fi

            alacrittySwitchTheme() {
              FROM=/Users/pontus.nagy/dotfiles/.config/alacritty
              TO=/Users/pontus.nagy/.config/alacritty
              if [[  $MODE == "dark"  ]]; then
                ln -fs $FROM/dark.toml $TO/live.toml
              elif [[  $MODE == "light"  ]]; then
                ln -fs $FROM/light.toml $TO/live.toml
              fi
            }

            alacrittySwitchTheme $@
          ''}"
        ];
      };
    };
  };
}

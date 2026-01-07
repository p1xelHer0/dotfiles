{ pkgs, ... }:
{
  nix.package = pkgs.lixPackageSets.stable.lix;

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

  system.primaryUser = "pontus.nagy";
  users.users."pontus.nagy" = {
    shell = pkgs.zsh;
    home = "/Users/pontus.nagy";
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      showhidden = true;

      mouse-over-hilite-stack = true;
      minimize-to-application = true;

      show-recents = false;
      mru-spaces = false;

      tilesize = 64;
      orientation = "bottom";
      magnification = false;

      enable-spring-load-actions-on-all-items = true;
    };

    CustomSystemPreferences."com.apple.dock" = {
      autohide-time-modifier = 0.0;
      autohide-delay = 0.0;
      expose-animation-duration = 0.0;
      springboard-show-duration = 0.0;
      springboard-hide-duration = 0.0;
      springboard-page-duration = 0.0;

      wvous-tl-corner = 0;
      wvous-tr-corner = 0;
      wvous-bl-corner = 0;
      wvous-br-corner = 0;

      launchanim = 0;
    };

    screencapture.location = "/Users/p1xelher0/Pictures/screenshots";

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

      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";

      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;

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
    ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Frog.aiff";
  };

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
      "homebrew/bundle"
    ];

    brews = [
      # "mas"
      "openssl@3"
      "llvm@17"
      "sdl3"
      "git"
      "node"
    ];

    casks = [
      "ghostty"
      "alt-tab"
      "appcleaner"
      "devcleaner"
      "firefox"
      "grandperspective"
      "hammerspoon"
      "karabiner-elements"
      "ngrok"
      "notion"
      "obsidian"
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
}

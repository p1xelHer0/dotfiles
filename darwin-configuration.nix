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

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = true;
    };

    screencapture.location = "${homeDir}/screenshots";

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain._HIHideMenuBar = true;
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./conf/_darwin/skhd/.skhdrc;
  };

  users.users.pontusnagy.shell = pkgs.zsh;
  users.users.pontusnagy.home = homeDir;

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
      window_border = "on";
      window_border_placement = "inset";
      window_border_width = 2;
      window_border_radius = 3;
      active_window_border_topmost = "off";
      window_topmost = "on";
      window_shadow = "float";
      active_window_border_color = "0xff5c7e81";
      normal_window_border_color = "0xff505050";
      insert_window_border_color = "0xffd75f5f";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };

    extraConfig = ''
      yabai -m rule --add app='System Preferences' manage=off
      yabai -m rule --add app='licecap' manage=off
    '';
  };

  # Copied verbatim from https://github.com/iknow/nix-channel/blob/7bf3584e0bef531836050b60a9bbd29024a1af81/darwin-modules/lorri.nix
  launchd.user.agents = {
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
  };

  # For use with nighthook:
  # If there's no 'live.yml' alacritty config initially, copy it
  # from the default config
  environment.extraInit = ''
    test -f ${homeDir}/.config/alacritty/live.yml || \
      cp ${homeDir}/.config/alacritty/alacritty.yml \
      ${homeDir}/.config/alacritty/live.yml
  '';

  launchd.user.agents.nighthook = {
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

          emacsSwitchTheme () {
            if pgrep -q Emacs; then
              if [[  $MODE == "dark"  ]]; then
                  emacsclient --eval "(cm/switch-theme 'doom-one)"
              elif [[  $MODE == "light"  ]]; then
                  emacsclient --eval "(cm/switch-theme 'doom-solarized-light)"
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

          emacsSwitchTheme $@
          alacrittySwitchTheme $@
          yabaiSwitchTheme $@
        ''}"
      ];
    };
  };
}

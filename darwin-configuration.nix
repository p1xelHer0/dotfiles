{ config, lib, pkgs, ... }:

let
  homeDir = builtins.getEnv ("HOME");
  user = builtins.getEnv ("USER");

in with pkgs.stdenv;
with lib; {
  imports = [ <home-manager/nix-darwin> ./lib/night.nix ];
  system.stateVersion = 4;
  environment.systemPackages = [ pkgs.zsh pkgs.lorri ];

  # darwin-rebuild switch -I darwin-config=$HOME/dotfiles/darwin-configuration.nix
  environment.darwinConfig = "${homeDir}/dotfiles/darwin-configuration.nix";

  programs.bash.enable = false;
  programs.zsh.enable = true;

  environment.shells = [ pkgs.zsh ];

  users.users."${user}" = {
    shell = pkgs.zsh;
    home = homeDir;
  };

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
      cmd - return : open -n ~/.nix-profile/Applications/Alacritty.app --args --live-config-reload --config-file $HOME/.config/alacritty/live.yml

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
                  spacebar -m config background_color 0xff080807
                  spacebar -m config foreground_color 0xffb5a488
                elif [[  $MODE == "light"  ]]; then
                  spacebar -m config background_color 0xfffaeed7
                  spacebar -m config foreground_color 0xff080807
                fi
              fi
            }

            alacrittySwitchTheme() {
              DIR=${homeDir}/.config/alacritty
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

  home-manager.users.pontusnagy = { config, pkgs, ... }: {
    home.stateVersion = "20.03";

    home.packages = with pkgs; [
      curl
      direnv
      fasd
      fswatch
      gitAndTools.diff-so-fancy
      gnupg
      htop
      jq
      neofetch
      niv
      reattach-to-user-namespace
      ripgrep
      shellcheck
      wget

      # fonts
      jetbrains-mono

      # nix
      nixfmt
      rnix-lsp

      # haskell
      # cabal-install
      # stack

      # ocaml
      bs-platform
      opam

      # rust
      # rustup
    ];

    fonts.fontconfig = { enable = true; };

    programs.zsh = {
      enable = true;

      enableAutosuggestions = false;
      enableCompletion = true;

      sessionVariables = {
        EDITOR = "nvim";
        LC_ALL = "en_US.UTF-8";

        DOTS_BIN = "$HOME/dotfiles/bin";
        DOTS_DARWIN_BIN = "$HOME/dotfiles/bin/_darwin";
      };

      envExtra = ''
        # profile zsh
        # zmodload zsh/zprof
      '';

      initExtra = ''
        export PATH=$DOTS_BIN:$PATH
        export PATH=$DOTS_DARWIN_BIN:$PATH

        # use the maximum amount of file descriptors
        ulimit -n 24576

        source "$DOTS_BIN/fzf_git"

        eval "$(fasd --init auto)"

        eval "$(fnm env --multi)"

        eval "$(direnv hook zsh)"

        eval "$(opam env)"

        source "$HOME/dev/repo/private/puck/puck.zsh"

        # eval "$(starship init zsh)"

        # profile zsh
        # zprof
      '';

      shellAliases = {
        ":q" = "tmux kill-pane";

        ip = "dig +short myip.opendns.com @resolver1.opendns.com";
        ipl =
          "ifconfig | grep -Eo 'inet (addr:)?([0-9]*.){3}[0-9]*' | grep -Eo '([0-9]*.){3}[0-9]*' | grep -v '127.0.0.1'";

        perf = "for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done";

        dre = "darwin-rebuild edit";
        drs =
          "darwin-rebuild switch -I darwin-config=$HOME/dotfiles/darwin-configuration.nix";

        v = "nvim";
        vim = "nvim";
        vf = "nvim $(fzf)";
        ev = "esy nvim";

        dots = "cd $HOME/dotfiles && nvim";
        swap = "tmux split-window 'cd $HOME/.local/share/nvim/swap && nvim'";

        rl = "exec zsh";

        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
      };

      plugins = [{
        name = "zsh-vim-mode";
        file = "zsh-vim-mode.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "softmoth";
          repo = "zsh-vim-mode";
          rev = "1fb4fec7c38815e55bc1b33e7c2136069278c798";
          sha256 = "1dxi18cpvbc96jl6w6j8r6zwpz8brjrnkl4kp8x1lzzariwm25sd";
        };
      }];
    };

    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./conf/tmux/.tmux.conf;

    };

    programs.fzf = {
      enable = true;

      enableZshIntegration = true;

      defaultCommand = "rg --files --hidden --follow";
      defaultOptions = [
        "--color=fg:-1"
        # "--color=bg:0"
        # "--color=preview-fg:0"
        # "--color=preview-bg:0"
        # "--color=hl:2"
        "--color=fg+:0"
        "--color=bg+:3"
        "--color=gutter:-1"
        "--color=hl+:8"
        # "--color=info:0"
        # "--color=border:0"
        # "--color=prompt:0"
        # "--color=pointer:-1"
        # "--color=marker:-1"
        # "--color=spinner:-1"
        # "--color=header:-1"

        # "--color=prompt:2,pointer:0,marker:3,spinner:1"
        "--reverse --no-bold --no-unicode --preview-window=hidden"
      ];

      fileWidgetCommand = "rg --files --hidden --follow";
      fileWidgetOptions = [
        "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
      ];

      changeDirWidgetCommand = "rg --files --hidden --follow";
      changeDirWidgetOptions = [ ];

      historyWidgetCommand = "";
      historyWidgetOptions = [ ];
    };

    programs.lf = { enable = true; };

    programs.neovim = {
      enable = true;

      extraConfig = ''
        colo ttwnty
        ${builtins.readFile ./conf/nvim/.vimrc}
      '';

      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
        ale
        editorconfig-vim
        fzf-vim
        neoformat
        nerdtree
        nerdtree-git-plugin
        supertab
        vim-commentary
        vim-easy-align
        vim-fugitive
        vim-plug
        vim-repeat
        vim-signify
        vim-slash
        vim-tmux-focus-events
        vim-tmux-navigator

        coc-nvim
        coc-fzf

        coc-tsserver
        coc-jest
        typescript-vim
        vim-javascript

        coc-css

        coc-json
        vim-json

        coc-html

        rust-vim
        coc-rls
        coc-rust-analyzer

        haskell-vim

        vim-markdown

        vim-graphql

        vim-nix
      ];
    };

    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Pontus Nagy";
      userEmail = "pontusnagy@gmail.com";
      includes = [{ path = "~/dotfiles/conf/git/.gitconfig"; }];
    };

    xdg.configFile."alacritty/light.yml".text = let
      lightColors = {
        colors = {
          primary.foreground = "#080807";
          primary.background = "#faeed7";

          normal = {
            black = "#faeed7";
            red = "#423730";
            green = "#585c4c";
            yellow = "#30261b";
            blue = "#080807";
            magenta = "#080807";
            cyan = "#080807";
            white = "#080807";
          };

          bright = {
            black = "#c9bfad";
            red = "#bf9d88";
            green = "#9da488";
            yellow = "#d1a47f";
            blue = "#080807";
            magenta = "#080807";
            cyan = "#080807";
            white = "#080807";
          };

          indexed_colors = [
            {
              index = 16;
              color = "#f2e6d0";
            }
            {
              index = 17;
              color = "#ebdfca";
            }
            {
              index = 18;
              color = "#e3d7c3";
            }
            {
              index = 19;
              color = "#dbd0bd";
            }
            {
              index = 20;
              color = "#d4c9b6";
            }
          ];
        };
      };
    in builtins.replaceStrings [ "\\\\" ] [ "\\" ]
    (builtins.toJSON (config.programs.alacritty.settings // lightColors));

    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          padding.x = 30;
          padding.y = 30;

          decorations = "buttonless";
          startup_mode = "Windowed";
        };

        draw_bold_text_with_bright_colors = true;

        live_config_reload = true;

        mouse.hide_when_typing = true;

        scrolling.history = 0;

        selection.save_to_clipboard = false;

        visual_bell.duration = 0;

        cursor = {
          style = "Block";
          unfocused_hollow = true;
        };

        font = {
          size = 16;

          normal = { family = "JetBrains Mono"; };

          use_thin_strokes = false;
        };

        colors = {
          primary.background = "0x080807";
          primary.foreground = "0xb5a488";

          cursor = {
            cursor = "0xb5a488";
            text = "0x080807";
          };

          normal = {
            black = "0x080807";
            red = "0xbf9d88";
            green = "0x9da488";
            yellow = "0xd1a47f";
            blue = "0xb5a488";
            magenta = "0xb5a488";
            cyan = "0xb5a488";
            white = "0xb5a488";
          };

          bright = {
            black = "0x30302c";
            red = "0xb5a488";
            green = "0xb5a488";
            yellow = "0xb5a488";
            blue = "0xb5a488";
            magenta = "0xb5a488";
            cyan = "0xb5a488";
            white = "0xb5a488";
          };

          indexed_colors = [
            {
              index = 16;
              color = "0x0d0d0b";
            }
            {
              index = 17;
              color = "0x121210";
            }
            {
              index = 18;
              color = "0x1a1917";
            }
            {
              index = 19;
              color = "0x242320";
            }
            {
              index = 20;
              color = "0x2b2b27";
            }
          ];
        };

        key_bindings = [
          {
            key = "Paste";
            action = "Paste";
          }
          {
            key = "Copy";
            action = "Copy";
          }
        ];
      };
    };
  };
}

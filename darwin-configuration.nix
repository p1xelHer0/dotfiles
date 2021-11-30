{ config, lib, pkgs, ... }:

let
  homeDir = builtins.getEnv ("HOME");
  user = builtins.getEnv ("USER");

in
with pkgs.stdenv;
with lib; {
  imports = [ <home-manager/nix-darwin> ./lib/night.nix ];
  system.stateVersion = 4;
  environment.systemPackages = [ pkgs.lorri pkgs.zsh ];

  # darwin-rebuild switch -I darwin-config=$HOME/dotfiles/darwin-configuration.nix
  environment.darwinConfig = "${homeDir}/dotfiles/darwin-configuration.nix";

  programs.zsh.enable = true;

  environment.shells = [ pkgs.zsh ];

  users.users."${user}" = {
    shell = pkgs.zsh;
    home = homeDir;
  };

  users.nix.configureBuildUsers = true;

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

  system.keyboard = {
    # enableKeyMapping = true;
    # remapCapsLockToControl = true;
  };

  fonts = {
    enableFontDir = true;
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;

    # Had no luck with this, run:
    # sudo yabai --install-sa after installation
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "on";

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
      alt - return : osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

      # disable mouse acceleration
      cmd + alt - m : $HOME/dev/Repo/Private/oss/killmouseaccel/kma mouse

      # focus window
      cmd - h : yabai -m window --focus west
      cmd - j : yabai -m window --focus south
      cmd - k : yabai -m window --focus north
      cmd - l : yabai -m window --focus east

      # move window
      shift + cmd - h : yabai -m window --warp west
      shift + cmd - j : yabai -m window --warp south
      shift + cmd - k : yabai -m window --warp north
      shift + cmd - l : yabai -m window --warp east

      # swap window
      ctrl + cmd - h : yabai -m window --swap west
      ctrl + cmd - j  : yabai -m window --swap south
      ctrl + cmd - k : yabai -m window --swap north
      ctrl + cmd - l : yabai -m window --swap east

      # balance size of windows
      shift + cmd - 0 : yabai -m space --balance

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

      # create desktop
      shift + cmd - n : yabai -m space --create

      # destroy desktop
      ctrl + cmd - w : yabai -m space --destroy

      # fast focus desktop
      ctrl + cmd - space : yabai -m space --focus last
      ctrl - right : yabai -m space --focus next
      ctrl - left : yabai -m space --focus prev
      ctrl - f1 : yabai -m space --focus 1
      ctrl - f2 : yabai -m space --focus 2
      ctrl - f3 : yabai -m space --focus 3
      ctrl - f4 : yabai -m space --focus 4
      ctrl - f5 : yabai -m space --focus 5
      ctrl - f6 : yabai -m space --focus 6
      ctrl - f7 : yabai -m space --focus 7
      ctrl - f8 : yabai -m space --focus 8
      ctrl - f9 : yabai -m space --focus 9
      ctrl - f10 : yabai -m space --focus 10
      ctrl - f11 : yabai -m space --focus 11
      ctrl - f12 : yabai -m space --focus 12

      # send window to desktop and follow focus
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
      # ctrl + cmd - e  : yabai -m display --focus 1
      # ctrl + cmd - r  : yabai -m display --focus 2

      # send window to monitor and follow focus
      # ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
      # ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
      # ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3

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

      # toggle window border
      alt - b : yabai -m window --toggle border

      # toggle window split type
      alt - e : yabai -m window --toggle split

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
                yabai -m window --grid 4:4:1:1:2:2
    '';

  };

  services.spacebar = {
    enable = true;
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

      text_font = ''"JetBrainsMono Nerd Font Mono:Regular:12.0"'';
      icon_font = ''"JetBrainsMono Nerd Font Mono:Regular:12.0"'';

      right_shell = "on";
      right_shell_command = "kb";

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
          PATH = (
            replaceStrings [ "$HOME" ] [ homeDir ]
              config.environment.systemPath
          );
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
                DIR=${homeDir}/.config/alacritty
                if [[  $MODE == "dark"  ]]; then
                  cp -f $DIR/alacritty.yml $DIR/live.yml
                elif [[  $MODE == "light"  ]]; then
                  cp -f $DIR/light.yml $DIR/live.yml
                fi
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

              spacebarSwitchTheme $@
              alacrittySwitchTheme $@
              yabaiSwitchTheme $@
            ''}"
        ];
      };
    };
  };

  home-manager.users.pontusnagy = { config, pkgs, ... }: {
    home.stateVersion = "20.09";

    # nixpkgs.overlays = [
    #   (
    #     import (
    #       builtins.fetchTarball {
    #         url =
    #           "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    #       }
    #     )
    #   )
    # ];

    home.packages = with pkgs; [
      cachix
      curl
      direnv
      fasd
      fswatch
      jq
      p7zip
      reattach-to-user-namespace
      ripgrep
      shellcheck
      tree
      tree-sitter
      watchman
      wget

      gh
      gitAndTools.diff-so-fancy
      gnupg

      flyctl

      htop
      irssi
      weechat
      protonmail-bridge

      ninja
      niv

      (nerdfonts.override
        { fonts = [ "JetBrainsMono" ]; })

      # Nix
      nixfmt
      rnix-lsp

      # Web
      fnm
      nodePackages.yarn
      nodePackages.pnpm
      nodePackages.vercel
      nodePackages.prettier
      nodePackages.vscode-json-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.typescript
      nodePackages.typescript-language-server

      # OCaml
      opam

      # Rust
      rustup
      rust-analyzer

      # Lua
      stylua
    ];

    programs.zsh = {
      enable = true;

      enableAutosuggestions = false;
      enableCompletion = true;

      sessionVariables = {
        EDITOR = "nvim";
        LC_ALL = "en_US.UTF-8";

        DOTS_BIN = "$HOME/dotfiles/bin";
        DOTS_DARWIN_BIN = "$HOME/dotfiles/bin/_darwin";
        RESCRIPT_LSP = "/Users/pontusnagy/.config/nvim/plugged/vim-rescript/rescript-vscode/extension/server/darwin/";
      };

      envExtra = ''
        # profile zsh
        # zmodload zsh/zprof
      '';

      initExtra = ''
        export PATH=$DOTS_BIN:$PATH
        export PATH=$DOTS_DARWIN_BIN:$PATH
        export PATH=$RESCRIPT_LSP:$PATH
        export RPROMPT=""

        # ZVM_LAZY_KEYBINDINGS=false
        # ZVM_VI_HIGHLIGHT_BACKGROUND=3

        # use the maximum amount of file descriptors
        ulimit -n 24576

        source "$DOTS_BIN/fzf_git"

        eval "$(fasd --init auto)"

        eval "$(fnm env)"

        eval "$(direnv hook zsh)"

        eval "$(opam env)"

        # zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

        # profile zsh
        # zprof
      '';

      shellAliases = {
        "l" = "clear";
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
        ev = "npx esy nvim";

        dots = "cd $HOME/dotfiles && nvim";
        swap = "tmux split-window 'cd $HOME/.local/share/nvim/swap && nvim'";

        fixusb = "sudo killall -STOP -c usbd";

        rl = "exec zsh";

        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
      };

      plugins = [
        # {
        #   name = "zsh-vi-mode";
        #   file = "zsh-vi-mode.plugin.zsh";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "jeffreytse";
        #     repo = "zsh-vi-mode";
        #     rev = "v0.8.3";
        #     sha256 = "13ack8bxa92mg1dp2q2n3j1fhc6pnv7dv7wm2sjcxnx6nf9i3766";
        #   };
        # }
      ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        scan_timeout = 10;

        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };

        format = ''
          $username$hostname$shlvl$kubernetes$directory$git_branch$git_commit$git_state$git_status$hg_branch$erlang$nodejs$ocaml$rust$nix_shell$cmd_duration$jobs$time$status
          $character'';

        directory = { read_only = "RO"; };

        git_branch.format = "$branch ";

        git_commit = {
          style = "bold cyan";
          tag_disabled = false;
          tag_symbol = "t ";
        };

        git_status = {
          format = "$all_status$ahead_behind ";

          conflicted = "";

          ahead = "[>](yellow)";
          behind = "[<](yellow)";
          diverged = "[?](bold red)";

          staged = "[^](green)";
          modified = "[~](yellow)";

          untracked = "[+](green)";
          renamed = ''["](green)'';
          deleted = "[-](red)";

          stashed = "[#]";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };

        nodejs = {
          format = "[$symbol($version )]($style)";
          symbol = "[node](green)";
        };

        ocaml = {
          format = "[$symbol($version )]($style)";
          symbol = "[ocaml](yellow)";
        };

        rust = {
          format = "[$symbol($version )]($style)";
          symbol = "[rust](red)";
        };

        nix_shell = {
          format = "[$symbol$state( ($name))]($style) ";
          symbol = "[nix](blue)";
        };
      };
    };

    programs.tmux = {
      enable = true;

      extraConfig = builtins.readFile ./conf/tmux/tmux.conf;

      plugins =
        with pkgs; [
          {
            plugin = tmuxPlugins.battery;
            extraConfig = ''
              set -g @batt_charged_icon " *"
              set -g @batt_charging_icon " +"
              set -g @batt_discharging_icon " -"
              set -g @batt_attached_icon " !"
            '';
          }
          tmuxPlugins.resurrect
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '15'
            '';
          }
        ];
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

      historyWidgetOptions = [ ];
    };

    programs.lf = { enable = true; };

    programs.neovim = {
      # package = pkgs.neovim-nightly;
      enable = true;

      extraConfig = builtins.readFile ./conf/nvim/init.vim;

      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
        packer-nvim
      ];
    };

    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Pontus Nagy";
      userEmail = "pontusnagy@gmail.com";
      includes = [{ path = "~/dotfiles/conf/git/.gitconfig"; }];
    };

    xdg.configFile."alacritty/light.yml".text =
      let
        lightColors = {
          colors = {
            primary.foreground = "#080807";
            primary.background = "#faeed7";

            normal = {
              black = "#faeed7";
              red = "0xbf9d88";
              green = "0x9da488";
              yellow = "0xd1a47f";
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
      in
      builtins.replaceStrings [ "\\\\" ] [ "\\" ]
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

        bell.duration = 0;

        cursor = {
          style = "Block";
          unfocused_hollow = true;
        };

        font = {
          size = 16;

          normal = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Regular";
          };

          bold = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold";
          };

          italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Italic";
          };

          bold_italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold Italic";
          };

          offset = {
            x = 0;
            y = 4;
          };

          glyph_offset = {
            x = 0;
            y = 2;
          };

          use_thin_strokes = true;
        };

        colors = {
          primary.background = "0x080807";
          primary.foreground = "0xb5a488";

          cursor = {
            cursor = "0xffffff";
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

    programs.neomutt = {
      enable = true;
    };

    programs.msmtp = {
      enable = true;
    };

    programs.offlineimap = {
      enable = true;
    };
  };
}

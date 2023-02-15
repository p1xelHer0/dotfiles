{ config, lib, pkgs, ... }:

let
  homeDir = builtins.getEnv ("HOME");
  user = builtins.getEnv ("USER");

in
with pkgs.stdenv;
with lib; {
  imports = [ <home-manager/nix-darwin> ./lib/night.nix ];
  system.stateVersion = 4;

  nix.configureBuildUsers = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  environment.systemPackages = with pkgs; [ nixUnstable zsh ];

  # darwin-rebuild switch -I darwin-config=$HOME/dotfiles/darwin-configuration.nix
  environment.darwinConfig = "${homeDir}/dotfiles/darwin-configuration.nix";

  programs.zsh.enable = true;

  environment.shells = [ pkgs.zsh ];

  users.users."${user}" = {
    shell = pkgs.zsh;
    home = homeDir;
  };

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

    screencapture.location = "${homeDir}/Pictures/screenshots";

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

  services.nix-daemon = {
    enable = true;
  };

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    global = {
      brewfile = true;
      lockfiles = true;
    };

    taps = [
      "fsouza/prettierd"
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-versions"
      "homebrew/core"
      "qmk/qmk"
      "michaeleisel/zld"
    ];

    brews = [
      "mas"
      "michaeleisel/zld/zld" # faster linker for Bevy development
      "pam-reattach" # run Touch ID within tmux
      "fsouza/prettierd/prettierd"
      "qmk/qmk/qmk"
      "sdl2"
      "sdl2_image"
      "sdl2_ttf"
    ];

    casks = [
      "1password-cli"
      "alt-tab"
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "gpg-suite-no-mail"
      "hammerspoon"
      "karabiner-elements"
      "keycastr"
      "linearmouse"
      "obs"
      "obsidian"
      "retroarch-metal"
      "secretive"
      "spotify"
      "visual-studio-code"
      "vlc"
    ];

    # extraConfig = ''
    #   cask "linearmouse", args: ["no-quarantine"]
    # '';

    masApps = {
      Developer = 640199958;
      GrandPerspective = 1111570163;
      "Key Codes" = 414568915;
      Messenger = 1480068668;
      Slack = 803453959;
      Telegram = 747648890;
      Twitter = 1482454543;
      Xcode = 497799835;
    };
  };

  services.yabai = {
    enable = false;
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

  # services.spotifyd = {
  #   enable = true;
  #   package = (pkgs.spotifyd.override { withKeyring = true; });
  # };

  # nighthook
  # if there's no 'live.yml' alacritty config initially,
  # copy it from the default config
  environment.extraInit = ''
    test -f ${homeDir}/.config/alacritty/live.yml || \
      cp ${homeDir}/.config/alacritty/alacritty.yml \
      ${homeDir}/.config/alacritty/live.yml
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
    #
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
                cp -f $DIR/dark.yml $DIR/live.yml
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

            # spacebarSwitchTheme $@
            alacrittySwitchTheme $@
            # yabaiSwitchTheme $@
          ''}"
        ];
      };
    };
  };

  home-manager.users.p1xelher0 = { config, pkgs, ... }: {
    home.stateVersion = "20.09";

    # build currently fails with this `true`, `false` for now
    manual.manpages.enable = false;

    xdg.configFile."nix/nix.conf".text = ''
      experimental-features = nix-command flakes
    '';

    home.packages = with pkgs; [
      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # Tools
      bat
      curl
      exa
      fasd # discontinued?
      fd
      fswatch
      htop
      jq
      p7zip
      reattach-to-user-namespace
      ripgrep
      gh
      hyperfine
      shellcheck
      simple-http-server
      tree
      tree-sitter
      delta
      flyctl
      watchman
      wget
      yamllint
      zoxide # fasd replacement but fasd is still better...?
      zola

      # Writing
      ispell
      nodePackages.write-good
      proselint

      # Nix
      cachix
      niv
      nixfmt
      rnix-lsp

      # Lua
      selene
      stylua
      sumneko-lua-language-server

      # Web
      fnm
      nodePackages.yarn
      nodePackages.vercel
      nodePackages.prettier
      nodePackages.eslint
      nodePackages.eslint_d
      nodePackages.vscode-json-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.tailwindcss

      # OCaml
      opam

      # Rust
      rustup
      # rust-analyzer - install this with Rustup instead
      # to make sure it matches the compiler

      # BQN
      cbqn

      # .NET
      dotnet-sdk_7
      omnisharp-roslyn

      # Python
      nodePackages.pyright
      python310Packages.autopep8

      # Go
      go
      gopls
      # go install github.com/mattn/efm-langserver@latest
      # go install github.com/segmentio/golines@latest
      # go install github.com/client9/misspell/cmd/misspell@latest

      # Lisp
      chicken
      guile
      chez-racket
      sbcl

      # Erlang/Elixir
      elixir
      elixir_ls

      # TOML
      taplo-cli
      taplo-lsp

      # YAML
      nodePackages.yaml-language-server
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
        GOPATH = "$HOME/go";
        GOPATH_BIN = "$GOPATH/bin";
        RESCRIPT_LSP =
          "/Users/p1xelher0/.config/nvim/plugged/vim-rescript/rescript-vscode/extension/server/darwin/";
      };

      envExtra = ''
        # profile zsh
        # zmodload zsh/zprof
      '';

      initExtra = ''
        export PATH=$DOTS_BIN:$PATH
        export PATH=$DOTS_DARWIN_BIN:$PATH
        export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
        export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

        export PATH=/opt/homebrew/bin:$PATH
        export PATH=$GOPATH:$PATH
        export PATH=$GOPATH_BIN:$PATH

        export PATH=$RESCRIPT_LSP:$PATH
        export RPROMPT=""

        # ZVM_LAZY_KEYBINDINGS=false
        # ZVM_VI_HIGHLIGHT_BACKGROUND=3

        # use the maximum amount of file descriptors
        ulimit -n 24576

        source "$DOTS_BIN/fzf_git"

        # eval "$(fasd --init auto)"
        eval "$(zoxide init zsh)"

        # eval "$(direnv hook zsh)"

        eval "$(fnm env)"

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

        os = "eval $(opam env)";
        ev = "npx esy nvim";
        evf = "npx esy nvim $(fzf)";

        dots = "cd $HOME/dotfiles && nvim";
        swap = "tmux split-window 'cd $HOME/.local/share/nvim/swap && nvim'";

        note = "tmux split-window -h 'cd $HOME/library/Mobile\\\ Documents/iCloud~md~obsidian/Documents/p1xelHer0 && nvim $(fzf)'";

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
          $username$hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$erlang$nodejs$ocaml$rust$nix_shell$cmd_duration$jobs$time$status
          $character'';

        directory = { read_only = "X"; };

        git_branch.format = "$branch ";

        git_commit = {
          style = "bold cyan";
          tag_disabled = true;
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

          stashed = "[# ](bold blue)";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };

        nodejs = {
          format = "[$symbol($version)]($style) ";
          symbol = "[node](green)";
        };

        ocaml = {
          format = "[$symbol($version)]($style) ";
          symbol = "[ocaml](yellow)";
        };

        rust = {
          format = "[$symbol($version)]($style) ";
          symbol = "[rust](red)";
        };

        nix_shell = {
          format = "[$symbol$state( ($name))]($style) ";
          symbol = "[nix](blue)";
          impure_msg = "i";
          pure_msg = "p";
        };
      };
    };

    programs.tmux = {
      enable = true;

      extraConfig = builtins.readFile ./.config/tmux/tmux.conf;

      plugins = with pkgs; [
        #   tmuxPlugins.resurrect
        #   {
        #     plugin = tmuxPlugins.continuum;
        #     extraConfig = ''
        #       set -g @continuum-restore 'on'
        #       set -g @continuum-save-interval '15'
        #     '';
        #   }
      ];
    };

    programs.fzf = {
      enable = true;

      enableZshIntegration = true;

      defaultCommand = "rg --files --hidden --smart-case";
      defaultOptions = [
        "--color=fg:7"
        "--color=bg:-1"
        "--color=preview-fg:7"
        "--color=preview-bg:-1"
        "--color=hl:reverse:3"
        "--color=fg+:7"
        "--color=bg+:18"
        "--color=gutter:-1"
        "--color=hl+:reverse:3"
        "--color=info:8"
        "--color=border:16"
        "--color=prompt:2"
        "--color=pointer:2"
        "--color=marker:2"
        "--color=spinner:1"
        "--color=header:8"

        "--reverse --no-bold --no-unicode --preview-window=hidden"
      ];
    };

    programs.neovim = {
      enable = true;
      # package = pkgs.neovim-nightly;

      extraConfig = builtins.readFile ./.config/nvim/init.vim;

      withNodeJs = false;
      withPython3 = false;
      withRuby = false;
    };

    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Pontus Nagy";
      userEmail = "p_nagy@icloud.com";
      includes = [{ path = "~/dotfiles/.config/git/.gitconfig"; }];
    };

    programs.direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };

    xdg.configFile."alacritty/dark.yml".text =
      let
        darkColors = {
          colors = {
            primary = {
              background = "0x0d1117";
              foreground = "0xb3b1ad";
            };

            cursor = {
              cursor = "0xffffff";
              text = "0x0d1117";
            };

            normal = {
              black = "0x0d1117";
              red = "0xff7b72";
              green = "0x3fb950";
              yellow = "0xd29922";
              blue = "0x58a6ff";
              magenta = "0xbc8cff";
              cyan = "0x39c5cf";
              white = "0xb1bac4";
            };

            bright = {
              black = "0x6e7681";
              red = "0xffa198";
              green = "0x56d364";
              yellow = "0xe3b341";
              blue = "0x79c0ff";
              magenta = "0xd2a8ff";
              cyan = "0x56d4dd";
              white = "0xf0f6fc";
            };

            indexed_colors = [
              { index = 16; color = "0x5d646e"; }
              { index = 17; color = "0x4c525b"; }
              { index = 18; color = "0x3b4149"; }
              { index = 19; color = "0x2c3037"; }
              { index = 20; color = "0x262a30"; }
            ];
          };
        };
      in
      builtins.replaceStrings [ "\\\\" ] [ "\\" ]
        (builtins.toJSON (config.programs.alacritty.settings // darkColors));


    xdg.configFile."alacritty/light.yml".text =
      let
        lightColors = {
          colors = {
            primary = {
              background = "0xffffff";
              foreground = "0x0e1116";
            };

            cursor = {
              cursor = "0x000000";
              text = "0xffffff";
            };

            normal = {
              black = "0xffffff";
              red = "0xcf222e";
              green = "0x116329";
              yellow = "0x4d2d00";
              blue = "0x0969da";
              magenta = "0x8250df";
              cyan = "0x1b7c83";
              white = "0x6e7781";
            };

            bright = {
              black = "0x57606a";
              red = "0xa40e26";
              green = "0x1a7f37";
              yellow = "0x633c01";
              blue = "0x218bff";
              magenta = "0xa475f9";
              cyan = "0x3192aa";
              white = "0x8c959f";
            };

            indexed_colors = [
              { index = 16; color = "0x9ca4ad"; }
              { index = 17; color = "0xadb4bb"; }
              { index = 18; color = "0xbec4c9"; }
              { index = 19; color = "0xcfd4d7"; }
              { index = 20; color = "0xe1e4e6"; }
            ];
          };
        };
      in
      builtins.replaceStrings [ "\\\\" ] [ "\\" ]
        (builtins.toJSON (config.programs.alacritty.settings // lightColors));

    programs.alacritty = {
      enable = true;

      settings = {
        env = {
          TERM = "xterm-256color";
        };

        window = {
          padding.x = 16;
          padding.y = 16;

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
            family = "JetBrainsMonoNL Nerd Font Mono";
            # family = "Menlo";
            # family = "BQN386 Unicode";
            style = "Medium";
          };

          bold = {
            family = "JetBrainsMonoNL Nerd Font Mono";
            # family = "Menlo";
            # family = "BQN386 Unicode";
            style = "ExtraBold";
          };

          italic = {
            family = "JetBrainsMonoNL Nerd Font Mono";
            # family = "Menlo";
            # family = "BQN386 Unicode";
            style = "Medium Italic";
          };

          bold_italic = {
            family = "JetBrainsMonoNL Nerd Font Mono";
            # family = "Menlo";
            # family = "BQN386 Unicode";
            style = "ExtraBold Italic";
          };

          offset = {
            x = 0;
            y = 12;
          };

          glyph_offset = {
            x = 0;
            y = 6;
          };
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

    programs.neomutt = { enable = false; };

    programs.msmtp = { enable = false; };

    programs.offlineimap = { enable = false; };
  };
}

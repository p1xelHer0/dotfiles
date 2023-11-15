{ config, pkgs, lib, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # Tools
    bat
    bitwarden-cli
    curl
    delta
    eza
    fd
    fswatch
    gh
    gnused # needed for nvim-spectre
    (pkgs.writeShellScriptBin "gsed" "exec ${pkgs.gnused}/bin/sed") # https://github.com/nvim-pack/nvim-spectre/issues/101
    (pkgs.writeShellScriptBin "reapamlol" "echo ${pkgs.pam-reattach}/lib/pam/pam_reattach.so")
    htop
    hyperfine
    jq
    lazygit
    p7zip
    reattach-to-user-namespace
    redis
    ripgrep
    scc
    shellcheck
    simple-http-server
    slides
    tree
    tree-sitter
    watchman
    wget
    yamllint
    zola
    zoxide

    # Writing
    ispell
    nodePackages.write-good
    proselint

    # Nix
    nixfmt
    rnix-lsp

    # Lua
    selene
    stylua
    sumneko-lua-language-server

    # Web
    fnm
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.eslint_d
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.tailwindcss

    # Elm
    elmPackages.elm
    elmPackages.elm-language-server
    elmPackages.elm-format

    # PHP
    php82
    php82Packages.composer

    # Ruby
    cocoapods
    ruby

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
    };

    envExtra = ''
      bindkey -s ^f "tmux-sessionizer\n"
    '';

    initExtra = ''
      export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
      export PATH=$DOTS_BIN:$PATH
      export PATH=$DOTS_DARWIN_BIN:$PATH
      export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

      export PATH=/opt/homebrew/bin:$PATH

      export PATH=$DOTS_BIN:$PATH

      export RPROMPT=""

      # use the maximum amount of file descriptors
      ulimit -n 24576

      source "$DOTS_BIN/fzf_git"

      eval "$(zoxide init zsh)"

      eval "$(fnm env)"
    '';

    shellAliases = {
      "l" = "clear";
      ":q" = "tmux kill-pane";

      "ts" = "tmux-sessionizer";
      "ta" = "tmux a";

      ip = "dig +short myip.opendns.com @resolver1.opendns.com";

      perf = "for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done";

      dre = "darwin-rebuild edit";
      drb = "nix build $HOME/dotfiles#darwinConfigurations.p1xelBook.system";
      drs =
        "darwin-rebuild switch --flake $HOME/dotfiles";

      v = "nvim";
      vim = "nvim";
      vf = "nvim $(fzf)";

      os = "eval $(opam env)";
      ev = "npx esy nvim";
      evf = "npx esy nvim $(fzf)";

      dots = "cd $HOME/dotfiles && nvim";
      nvsh = "tmux split-window 'cd $HOME/.local/share/nvim && nvim'";
      nvst = "tmux split-window 'cd $HOME/.local/state/nvim && nvim'";
      nvc = "tmux split-window 'cd $HOME/.cache/nvim && nvim'";

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
  # defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
  xdg.configFile."hammerspoon/init.lua".source = mkOutOfStoreSymlink "/Users/pontusnagy/dotfiles/.config/_darwin/hammerspoon/init.lua";

  xdg.configFile."zellij/config.kdl".source = mkOutOfStoreSymlink "/Users/pontusnagy/dotfiles/.config/zellij/config.kdl";
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."tmux/tmux.conf".source = mkOutOfStoreSymlink "/Users/pontusnagy/dotfiles/.config/tmux/tmux.conf";
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
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

  xdg.configFile."theme".text = "dark";

  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "/Users/pontusnagy/dotfiles/.config/nvim/lua";
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
    extraConfig = "lua require('init')";
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Pontus Nagy";
    userEmail = "pontus.nagy@savr.com";
    includes = [{ path = "~/dotfiles/.config/git/.gitconfig"; }];
    /**/
    /* extraConfig = { */
    /*   diff.colorAdded = "2"; */
    /*   diff.colorChanged = "3"; */
    /*   diff.colorUntracked = "2"; */
    /*   diff.colorMoved = "2"; */
    /* }; */
    /**/
    /* delta = { */
    /*   enable = true; */
    /* }; */
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
            background = "0x222436";
            foreground = "0xc8d3f5";
          };

          cursor = {
            cursor = "0xffffff";
            text = "0x222436";
          };

          normal = {
            black = "0x222436";
            red = "0xff757f";
            green = "0xc3e88d";
            yellow = "0xffc777";
            blue = "0x82aaff";
            magenta = "0xc099ff";
            cyan = "0x86e1fc";
            white = "0x828bb8";
          };

          bright = {
            black = "0x444a73";
            red = "0xff757f";
            green = "0xc3e88d";
            yellow = "0xffc777";
            blue = "0x82aaff";
            magenta = "0xc099ff";
            cyan = "0x86e1fc";
            white = "0xc8d3f5";
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
            background = "0xe1e2e7";
            foreground = "0x3760bf";
          };

          cursor = {
            cursor = "0x000000";
            text = "0xe1e2e7";
          };

          normal = {
            black = "0xe1e2e7";
            red = "0xf52a65";
            green = "0x587539";
            yellow = "0x8c6c3e";
            blue = "0x2e7de9";
            magenta = "0x9854f1";
            cyan = "0x007197";
            white = "0x6172b0";
          };

          bright = {
            black = "0xa1a6c5";
            red = "0xf52a65";
            green = "0x587539";
            yellow = "0x8c6c3e";
            blue = "0x2e7de9";
            magenta = "0x9854f1";
            cyan = "0x007197";
            white = "0x3760bf";
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

  programs.alacritty =
    let
      # fontFamily = "Iosevka Nerd Font Mono";
      # fontFamily = "MesloLGL Nerd Font Mono";
      fontFamily = "JetBrainsMonoNL Nerd Font Mono";
    in
    {
      enable = true;

      settings = {
        env = {
          TERM = "alacritty";
        };

        window = {
          padding.x = 16;
          padding.y = 16;

          decorations = "buttonless";
          startup_mode = "Windowed";
          option_as_alt = "Both";
        };

        draw_bold_text_with_bright_colors = false;

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
          size = 12;

          normal = {
            family = fontFamily;
            style = "Regular";
            # style = "SemiBold";
          };

          bold = {
            family = fontFamily;
            style = "Bold";
            # style = "ExtraBold";
          };

          italic = {
            family = fontFamily;
            style = "Italic";
            # style = "SemiBold Italic";
          };

          bold_italic = {
            family = fontFamily;
            style = "Bold Italic";
            # style = "ExtraBold Italic";
          };

          offset = {
            x = 1;
            y = 4;
          };

          glyph_offset = {
            x = 0;
            y = 2;
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
}

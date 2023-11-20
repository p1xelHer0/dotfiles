{ config, pkgs, lib, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" "Meslo" ]; })

    # Tools
    bat
    curl
    delta
    eza
    fd
    ffmpeg
    flyctl
    fswatch
    gh
    gifsicle
    gnused # needed for nvim-spectre
    (pkgs.writeShellScriptBin "gsed" "exec ${pkgs.gnused}/bin/sed") # https://github.com/nvim-pack/nvim-spectre/issues/101
    (pkgs.writeShellScriptBin "reapamlol" "echo ${pkgs.pam-reattach}/lib/pam/pam_reattach.so")
    htop
    hyperfine
    imagemagick
    jq
    p7zip
    reattach-to-user-namespace
    ripgrep
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
    # nodePackages.yarn
    nodePackages.pnpm
    # nodePackages.vercel
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
    cargo-watch
    cargo-nextest
    # rust-analyzer - install this with Rustup instead
    # to make sure it matches the compiler

    # C/C++/Rust
    # vscode-extensions.vadimcn.vscode-lldb

    # Elm
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-language-server
    elmPackages.elm-review
    elmPackages.elm-test

    # BQN
    cbqn

    # Python
    # nodePackages.pyright
    # python310Packages.autopep8

    # Go
    # go
    # gopls
    # go install github.com/mattn/efm-langserver@latest
    # go install github.com/segmentio/golines@latest
    # go install github.com/client9/misspell/cmd/misspell@latest

    # Lisp
    # chicken
    # guile
    # chez-racket
    # sbcl

    # Erlang/Elixir
    # elixir
    # elixir_ls

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
      MACTEX_BIN = "/usr/local/texlive/2023/bin/universal-darwin";
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
      export PATH=$GOPATH:$PATH
      export PATH=$GOPATH_BIN:$PATH

      export PATH=$DOTS_BIN:$PATH

      export PATH=$RESCRIPT_LSP:$PATH

      export PATH=$MACTEX_BIN:$PATH

      export RPROMPT=""

      # use the maximum amount of file descriptors
      ulimit -n 24576

      source "$DOTS_BIN/fzf_git"

      eval "$(zoxide init zsh)"

      eval "$(direnv hook zsh)"

      eval "$(fnm env)"

      eval "$(opam env)"
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

      opameval = "eval $(opam env)";
      ev = "npx esy nvim";
      evf = "npx esy nvim $(fzf)";

      dots = "cd $HOME/dotfiles && nvim";
      nvsh = "tmux split-window 'cd $HOME/.local/share/nvim && nvim'";
      nvst = "tmux split-window 'cd $HOME/.local/state/nvim && nvim'";
      nvc = "tmux split-window 'cd $HOME/.cache/nvim && nvim'";

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
  # defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
  xdg.configFile."hammerspoon/init.lua".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/_darwin/hammerspoon/init.lua";

  xdg.configFile."zellij/config.kdl".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/zellij/config.kdl";
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."tmux/tmux.conf".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/tmux/tmux.conf";
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

  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/nvim/lua";
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
    userEmail = "p_nagy@icloud.com";
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
            background = "0x0d1117";
            foreground = "0xc9d1d9";
          };

          cursor = {
            cursor = "0xc9d1d9";
            text = "0x0d1117";
          };

          normal = {
            black = "0x0d1117";
            red = "0xff7b72";
            green = "0x58a6ff";
            yellow = "0xd29922";
            blue = "0x58a6ff";
            magenta = "0xbc8cff";
            cyan = "0x39c5cf";
            white = "0xb1bac4";
          };

          bright = {
            black = "0x6e7681";
            red = "0xffa198";
            green = "0x79c0ff";
            yellow = "0xe3b341";
            blue = "0x79c0ff";
            magenta = "0xbc8cff";
            cyan = "0x39c5cf";
            white = "0xb1bac4";
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
            foreground = "0x1b1f24";
          };

          cursor = {
            cursor = "0x24292f";
            text = "0xffffff";
          };

          normal = {
            black = "0xffffff";
            red = "0xcf222e";
            green = "0x0550ae";
            yellow = "0x4d2d00";
            blue = "0x0969da";
            magenta = "0x8250df";
            cyan = "0x1b7c83";
            white = "0x6e7781";
          };

          bright = {
            black = "0x57606a";
            red = "0xa40e26";
            green = "0x0969da";
            yellow = "0x633c01";
            blue = "0x218bff";
            magenta = "0x8250df";
            cyan = "0x1b7c83";
            white = "0x6e7781";
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
      fontFamily = "Iosevka Nerd Font Mono";
      # fontFamily = "MesloLGL Nerd Font Mono";
      # fontFamily = "JetBrainsMonoNL Nerd Font Mono";
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
          size = 22;

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

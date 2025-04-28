{ config, pkgs, lib, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term
    nerd-fonts.blex-mono
    nerd-fonts.gohufont
    nerd-fonts.bigblue-terminal

    # Tools
    aerospace
    cmake
    curl
    entr
    eza
    fd
    ffmpeg
    fswatch
    gh
    # gifsicle
    gnused
    (pkgs.writeShellScriptBin "
        gsed
        " "
        exec ${pkgs.gnused}/bin/sed \"$@\"") # https://github.com/nvim-pack/nvim-spectre/issues/101
    htop
    hyperfine
    imagemagick
    jq
    p7zip
    readline
    reattach-to-user-namespace
    ripgrep
    ninja
    shellcheck
    tmuxinator
    tree
    tree-sitter
    watchman
    wget
    yamllint
    zola
    zoxide

    # C/C++
    # ncurses6
    # cmake
    # gcc13
    ccls
    nasm
    # vscode-extensions.vadimcn.vscode-lldb

    # Zig
    # zig

    # Odin
    # odin
    # ols

    # Writing
    # ispell
    # nodePackages.write-good
    # proselint

    # Nix
    # cachix
    # niv
    nixpkgs-fmt
    nil

    # Lua
    stylua
    sumneko-lua-language-server

    # Web
    fnm
    biome
    # nodePackages.yarn
    # nodePackages.pnpm
    # nodePackages.vercel
    # nodePackages.prettier
    # nodePackages.eslint
    # nodePackages.eslint_d
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.tailwindcss

    # OCaml
    # opam

    # Rust
    rustup
    # cargo-watch
    # cargo-nextest
    # wasmer
    # rust-analyzer - install this with Rustup instead
    # to make sure it matches the compiler

    # Haskell
    # haskellPackages.ghcup

    # Elm
    # elmPackages.elm
    # elmPackages.elm-format
    # elmPackages.elm-language-server
    # elmPackages.elm-review
    # elmPackages.elm-test

    # BQN
    # cbqn

    # Python oh no
    # python3
    # nodePackages.pyright
    # python310Packages.autopep8

    # Go
    go
    gopls
    # go install github.com/mattn/efm-langserver@latest
    # go install github.com/segmentio/golines@latest
    # go install github.com/client9/misspell/cmd/misspell@latest

    ## Lisps

    # Common Lisp
    # sbcl # installed with roswell
    # roswell # brew
    # lispPackages.quicklisp # handled with ros install qlot
    # sbclPackages.qlot # see https://github.com/fukamachi/qlot#installation

    # Scheme
    # gerbil # brew
    # gerbil-unstable # brew
    # cyclone-scheme # brew
    # chicken
    # gambit
    # guile
    # mitscheme

    # Clojure
    # clojure
    # leiningen
    # clojure-lsp
    # cljfmt

    # Racket
    # racket # broken on macOS - using brew
    # racket-minimal # broken on macOS - using brew
    # raco pkg install racket-langserver

    # Lua
    luajit

    # Fennel
    # luaPackages.fennel
    # cargo install --git https://github.com/rydesun/fennel-language-server

    # Janet
    # janet
    # jpm

    # Erlang/Elixir
    # elixir
    # elixir_ls

    # TOML
    taplo-cli
    taplo-lsp

    # YAML
    # nodePackages.yaml-language-server
  ];

  xdg.configFile."karabiner/".source = mkOutOfStoreSymlink "/Users/p1xelHer0/dotfiles/.config/_darwin/karabiner/";

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
      LC_ALL = "en_US.UTF-8";

      DOTS = "$HOME/dotfiles";
      DOTS_BIN = "$DOTS/bin";
      DOTS_DARWIN_BIN = "$DOTS_BIN/_darwin";

      GOPATH = "$HOME/go";
      GOPATH_BIN = "$GOPATH/bin";

      ODIN_ROOT = "$HOME/code/github/odin-lang/Odin";
      ODIN_TOOLS = "$HOME/code/github/DanielGavin/ols";

      SDL_SHADERCROSS = "$HOME/dotfiles/bin/SDL3_shadercross-3.0.0-darwin-arm64-x64/bin";

      ZIGUP = "$HOME/code/github/marler8997/zigup/bin";
      ZLS = "$HOME/code/github/zigtools/zls/zig-out/bin";

      # MACTEX_BIN = "/usr/local/texlive/2023/bin/universal-darwin";

      # ROSWELL_BIN = "$HOME/.roswell/bin";
      # QLOT_BIN = "$HOME/.qlot/bin";

      TMUXINATOR_CONFIG = "$DOTS/.config/tmux/tmuxinator";

      RPROMPT = " ";
    };

    envExtra = ''
        bindkey -s ^f "
      tmux-sessionizer\
      n "
    '';

    initExtra = ''
      export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
      export PATH=$DOTS_BIN:$PATH
      export PATH=$DOTS_DARWIN_BIN:$PATH

      # Secretive
      export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@3/lib/pkgconfig

      export PATH=/opt/homebrew/bin:$PATH
      export PATH=/opt/homebrew/opt/ncurses/bin:$PATH

      export PATH=$GOPATH:$PATH
      export PATH=$GOPATH_BIN:$PATH

      export PATH=$DOTS_BIN:$PATH

      export PATH=$RESCRIPT_LSP:$PATH

      # export PATH=$MACTEX_BIN:$PATH

      export PATH=$ROSWELL_BIN:$PATH
      export PATH=$QLOT_BIN:$PATH

      # Gerbil
      # export CC=gcc-13

      # Odin
      export PATH=/opt/homebrew/opt/llvm@17/bin:$PATH
      export PATH=$ODIN_ROOT:$PATH
      export PATH=$ODIN_TOOLS:$PATH

      export PATH=$SDL_SHADERCROSS:$PATH

      export PATH=$ZIGUP:$PATH
      export PATH=$ZLS:$PATH

      # use the maximum amount of file descriptors
      ulimit -n 24576

      source "$DOTS_BIN/fzf_git"

      eval "$(zoxide init zsh)"

      eval "$(fnm env)"

      # eval "$(opam env)"
    '';

    shellAliases = {
      "l" = "clear";
      ":q" = "tmux kill-pane";

      "ts" = "tmux-sessionizer";
      "ta" = "tmux a";

      dre = "darwin-rebuild edit";
      drs =
        "darwin-rebuild switch --flake $HOME/dotfiles";

      v = "nvim";
      vim = "nvim";
      vf = "nvim $(fzf)";

      # opameval = "eval $(opam env)";
      # ev = "npx esy nvim";
      # evf = "npx esy nvim $(fzf)";

      dots = "cd $HOME/dotfiles && nvim";
      nvsh = "tmux split-window 'cd $HOME/.local/share/nvim && nvim'";
      nvst = "tmux split-window 'cd $HOME/.local/state/nvim && nvim'";
      nvc = "tmux split-window 'cd $HOME/.cache/nvim && nvim'";

      note = "tmux split-window -h 'cd $HOME/library/Mobile\\\ Documents/iCloud~md~obsidian/Documents/p1xelHer0 && nvim $(fzf)'";

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
        success_symbol = "[;](bold green)";
        error_symbol = "[;](bold red)";
      };

      format = ''
        $username$hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$nodejs$ocaml$rust$zig$nix_shell$cmd_duration$jobs$time$status
        $character'';

      directory = { read_only = "X"; };

      git_branch.format = "$branch ";

      git_commit = {
        style = "bold cyan";
        tag_disabled = true;
      };

      git_status = {
        format = "$all_status$ahead_behind ";

        conflicted = "[=](red)";

        ahead = "[>](yellow)";
        behind = "[<](yellow)";
        diverged = "[?](bold red)";

        staged = "[^](green)";
        modified = "[~](yellow)";

        untracked = "[+](green)";
        renamed = ''["](green)'';
        deleted = "[-](red)";

        stashed = "[#](bold blue)";
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

      zig = {
        format = "[$symbol($version)]($style) ";
        symbol = "[zig](yellow)";
      };

      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        symbol = "[nix](blue)";
        impure_msg = "";
        pure_msg = "";
      };
    };
  };

  xdg.configFile."hammerspoon/init.lua".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/_darwin/hammerspoon/init.lua";

  xdg.configFile."zellij/config.kdl".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/zellij/config.kdl";
  programs.zellij = {
    enable = false;
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
      "--color=bg+:8"
      "--color=gutter:-1"
      "--color=hl+:reverse:3"
      "--color=info:8"
      "--color=border:8"
      "--color=prompt:2"
      "--color=pointer:2"
      "--color=marker:2"
      "--color=spinner:1"
      "--color=header:8"

      "--reverse --no-bold --no-unicode --preview-window=hidden"
    ];
  };

  xdg.configFile."nvim/after".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/nvim/after";
  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/nvim/lua";
  xdg.configFile."nvim/lsp".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/nvim/lsp";
  xdg.configFile."nvim/init.lua".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/nvim/init.lua";
  programs.neovim = {
    enable = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "p1xelHer0";
    userEmail = "p_nagy@icloud.com";
    includes = [{ path = "~/dotfiles/.config/git/.gitconfig"; }];
  };

  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  xdg.configFile."aerospace/aerospace.toml".source = mkOutOfStoreSymlink "/Users/p1xelHer0/dotfiles/.config/_darwin/aerospace.toml";
  # programs.aerospace = {
  #   enable = true;
  # };

  home.file."Library/Preferences/clangd/config.yaml" = {
    source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/clangd.yaml";
  };

  xdg.configFile."ghostty".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/.config/ghostty";
}

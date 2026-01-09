{
  config,
  pkgs,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.bigblue-terminal
    nerd-fonts.blex-mono
    nerd-fonts.cousine
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.gohufont
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.jetbrains-mono
    nerd-fonts.lilex
    nerd-fonts.monaspace
    maple-mono.truetype

    # Tools
    curl
    entr
    eza
    fd
    ffmpeg
    figlet
    fswatch
    gh
    hyperfine
    imagemagick
    jq
    jujutsu
    nushell
    p7zip
    qmk
    readline
    reattach-to-user-namespace
    ripgrep
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
    ninja
    nasm
    vscode-extensions.vadimcn.vscode-lldb

    # Nix
    nil
    nixfmt-rfc-style

    # Slang
    shader-slang

    # Lua
    lua-language-server
    selene
    stylua

    # Rust
    rustup

    # Python
    uv
    ruff
    ty

    # Go
    go
    gopls
    gotools
    go-tools
    delve
    gofumpt

    # Lua
    luajit

    # TOML
    taplo
  ];

  xdg.configFile."karabiner/".source =
    mkOutOfStoreSymlink "/Users/p1xelHer0/dotfiles/config/_darwin/karabiner/";

  home.file."Library/Application Support/nushell/config.nu".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/config/nushell/config.nu";

  home.file."Library/Application Support/nushell/env.nu".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/config/nushell/env.nu";

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
      LC_ALL = "en_US.UTF-8";
      RPROMPT = " ";

      DOTS = "$HOME/dotfiles";
      DOTS_BIN = "$DOTS/bin";
      DOTS_DARWIN_BIN = "$DOTS_BIN/_darwin";

      TMUXINATOR_CONFIG = "$DOTS/config/tmux/tmuxinator";

      CODELLDB_BIN = "$HOME/.vscode/extensions/vadimcn.vscode-lldb-1.12.1/adapter";

      GOPATH = "$HOME/go";
      GOPATH_BIN = "$GOPATH/bin";

      ODIN_ROOT = "$HOME/code/github/odin-lang/Odin";
      ODIN_TOOLS = "$HOME/code/github/DanielGavin/ols";

      ZIGUP = "$HOME/code/github/marler8997/zigup/bin";
      ZLS = "$HOME/code/github/zigtools/zls/zig-out/bin";
    };

    envExtra = ''
        bindkey -s ^f "
      tmux-sessionizer\
      n "
    '';

    initContent = ''
      export PATH=$DOTS_BIN:$PATH
      export PATH=$DOTS_DARWIN_BIN:$PATH

      # Secretive
      export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@3/lib/pkgconfig

      export PATH=/opt/homebrew/bin:$PATH

      eval "$(zoxide init zsh)"

      eval "$(fnm env)"

      # LLDB
      export PATH=$CODELLDB_BIN:$PATH

      # LLVM
      export PATH=/opt/homebrew/opt/llvm@21/bin:$PATH

      # GCC
      export PATH=/opt/homebrew/opt/gcc@15/bin:$PATH

      # Odin
      export PATH=$ODIN_ROOT:$PATH
      export PATH=$ODIN_TOOLS:$PATH

      # Zig
      export PATH=$ZIGUP:$PATH
      export PATH=$ZLS:$PATH

      # Rust
      export PATH=$HOME/.cargo/bin:$PATH

      # Go
      export PATH=$GOPATH:$PATH
      export PATH=$GOPATH_BIN:$PATH
    '';

    shellAliases = {
      "l" = "clear";
      ":q" = "tmux kill-pane";

      "ts" = "tmux-sessionizer";
      "ta" = "tmux a";

      dre = "sudo darwin-rebuild edit";
      drs = "sudo darwin-rebuild switch --flake $HOME/dotfiles";

      v = "nvim";
      vim = "nvim";
      vp = "nvim -c 'lua require(\"fzf-lua\").files()'";
      vf = "nvim -c 'lua require(\"fzf-lua\").live_grep_native()'";
      vg = "nvim -c 'lua require(\"neogit\").open()'";

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

      directory = {
        read_only = "X";
      };

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

  xdg.configFile."hammerspoon/init.lua".source =
    mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/config/_darwin/hammerspoon/init.lua";

  xdg.configFile."zellij/config.kdl".source =
    mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/config/zellij/config.kdl";
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."tmux/tmux.conf".source =
    mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/config/tmux/tmux.conf";
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
  xdg.configFile."nvim/init.lua".source =
    mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/nvim/init.lua";
  programs.neovim = {
    enable = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  xdg.configFile."aerospace/aerospace.toml".source =
    mkOutOfStoreSymlink "/Users/p1xelHer0/dotfiles/config/_darwin/aerospace.toml";

  xdg.configFile."sketchybar/sketchybarrc".source =
    mkOutOfStoreSymlink "/Users/p1xelHer0/dotfiles/config/_darwin/sketchybarrc";

  home.file."Library/Preferences/clangd/config.yaml" = {
    source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/config/clangd.yaml";
  };

  xdg.configFile."ghostty".source = mkOutOfStoreSymlink "/Users/p1xelher0/dotfiles/config/ghostty";
}

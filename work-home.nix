{
  config,
  pkgs,
  lib,
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
    # bitwarden-cli
    aerospace
    curl
    entr
    eza
    fd
    fswatch
    gh
    jq
    mob
    p7zip
    reattach-to-user-namespace
    redis
    ripgrep
    scc
    shellcheck
    tmuxinator
    tree
    tree-sitter
    watchman
    wget
    yamllint
    zoxide

    # ngrok

    # Writing
    # ispell
    # nodePackages.write-good
    # proselint

    # Nix
    nil
    nixfmt-rfc-style

    # Lua
    lua-language-server
    selene
    stylua

    # Web
    fnm
    biome
    tailwindcss-language-server
    # nodePackages.prettier
    # nodePackages.eslint
    # nodePackages.eslint_d
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Elm
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-language-server
    elmPackages.elm-test

    # Go
    go
    gopls
    gotools
    go-tools
    delve
    gofumpt

    # PHP
    # php82
    # php82Packages.composer
    php83
    php83Packages.composer
    phpactor

    # Ruby
    # cocoapods
    # ruby

    # TOML
    taplo

    # YAML
    nodePackages.yaml-language-server
  ];

  xdg.configFile."karabiner/".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/_darwin/karabiner/";

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

      ODIN_ROOT = "$HOME/code/github/odin-lang/Odin";
      ODIN_TOOLS = "$HOME/code/github/DanielGavin/ols";

      TMUXINATOR_CONFIG = "$DOTS/.config/tmux/tmuxinator";

      RPROMPT = " ";
    };

    envExtra = ''
      bindkey -s ^f "tmux-sessionizer\n"
    '';

    initContent = ''
      export PATH=$DOTS_BIN:$PATH
      export PATH=$DOTS_DARWIN_BIN:$PATH

      # Secretive
      export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@3/lib/pkgconfig

      export PATH=/opt/homebrew/bin:$PATH

      # Odin
      export PATH=/opt/homebrew/opt/llvm@17/bin:$PATH
      export PATH=$ODIN_ROOT:$PATH
      export PATH=$ODIN_TOOLS:$PATH

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

      dre = "sudo darwin-rebuild edit";
      drs = "sudo darwin-rebuild switch --flake $HOME/dotfiles";

      v = "nvim";
      vim = "nvim";
      vp = "nvim -c 'lua require(\"fzf-lua\").files()'";
      vf = "nvim -c 'lua require(\"fzf-lua\").live_grep_native()'";
      vg = "nvim -c 'lua require(\"neogit\").open()'";

      yamld = "nvim -d ./.docker/local/docker-compose.yml ./.docker/local/docker-compose.yml.example";
      envd = "nvim -d .env .env.example";

      dots = "cd $HOME/dotfiles && nvim";
      nvsh = "tmux split-window 'cd $HOME/.local/share/nvim && nvim'";
      nvst = "tmux split-window 'cd $HOME/.local/state/nvim && nvim'";
      nvc = "tmux split-window 'cd $HOME/.cache/nvim && nvim'";

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

      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        symbol = "[nix](blue)";
        impure_msg = "";
        pure_msg = "";
      };
    };
  };

  xdg.configFile."hammerspoon/init.lua".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/_darwin/hammerspoon/init.lua";

  xdg.configFile."tmux/tmux.conf".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/tmux/tmux.conf";
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

  xdg.configFile."nvim/after".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/nvim/after";
  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/nvim/lua";
  xdg.configFile."nvim/lsp".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/nvim/lsp";
  xdg.configFile."nvim/init.lua".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/nvim/init.lua";
  programs.neovim = {
    enable = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  programs.git = {
    enable = false;
    package = pkgs.gitAndTools.gitFull;
    settings = {
      user = {
        name = "Pontus Nagy";
        email = "pontus.nagy@savr.com";
      };
    };

    includes = [ { path = "~/dotfiles/.config/git/.gitconfig"; } ];
  };

  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  xdg.configFile."aerospace/aerospace.toml".source =
    mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/_darwin/aerospace.toml";
  # programs.aerospace = {
  #   enable = true;
  # };

  xdg.configFile."ghostty".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/ghostty";
}

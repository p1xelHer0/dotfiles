{ config, pkgs, lib, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "IosevkaTerm"
        "JetBrainsMono"
        "Meslo"
      ];
    })

    # Tools
    bitwarden-cli
    curl
    entr
    eza
    fd
    fswatch
    gh
    (pkgs.writeShellScriptBin "gsed" "exec ${pkgs.gnused}/bin/sed \"$@\"") # https://github.com/nvim-pack/nvim-spectre/issues/101
    htop
    jq
    mob
    p7zip
    reattach-to-user-namespace
    redis
    ripgrep
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
    ispell
    nodePackages.write-good
    proselint

    # Nix
    nixpkgs-fmt
    nil

    # Lua
    stylua
    sumneko-lua-language-server

    # Web
    fnm
    biome
    tailwindcss-language-server
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.eslint_d
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Elm
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-language-server
    elmPackages.elm-test

    # PHP
    # php82
    # php82Packages.composer
    php83
    php83Packages.composer
    phpactor

    # Ruby
    cocoapods
    ruby

    # TOML
    taplo-cli
    taplo-lsp

    # YAML
    nodePackages.yaml-language-server
  ];

  xdg.configFile."karabiner/".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/_darwin/karabiner/";

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

      export TMUXINATOR_CONFIG=$DOTS/.config/tmux/tmuxinator

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

      yamld = "nvim -d ./.docker/local/docker-compose.yml ./.docker/local/docker-compose.yml.example";
      envd = "nvim -d .env .env.example";

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

  xdg.configFile."hammerspoon/init.lua".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/_darwin/hammerspoon/init.lua";

  xdg.configFile."zellij/config.kdl".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/zellij/config.kdl";
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."tmux/tmux.conf".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/tmux/tmux.conf";
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

  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "/Users/pontus.nagy/dotfiles/.config/nvim/lua";
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim; # this enables nightly
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

  programs.alacritty =
    let
      # fontFamily = "IosevkaTerm Nerd Font Mono";
      # fontFamily = "BlexMono Nerd Font Mono";
      # fontFamily = "MesloLGL Nerd Font Mono";
      fontFamily = "JetBrainsMonoNL Nerd Font Mono";
    in
    {
      enable = true;

      settings = {
        window = {
          padding.x = 16;
          padding.y = 16;

          decorations = "buttonless";
          startup_mode = "Windowed";
          option_as_alt = "Both";
        };

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
          size = 18;

          normal.family = fontFamily;
          bold.family = fontFamily;
          italic.family = fontFamily;
          bold_italic.family = fontFamily;

          offset = {
            x = 1;
            y = 1;
          };

          glyph_offset = {
            x = 0;
            y = 0;
          };
        };

        keyboard = {
          bindings = [
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

        import = [ "~/.config/alacritty/live.toml" ];
      };
    };
}

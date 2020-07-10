{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "20.03";

  home.packages = with pkgs; [
    bash
    curl
    direnv
    fasd
    fswatch
    gitAndTools.diff-so-fancy
    gnupg
    htop
    jq
    niv
    reattach-to-user-namespace
    ripgrep
    shellcheck
    starship
    wget

    # fonts
    jetbrains-mono

    # keyboards
    # dfu-util

    # window manager
    skhd
    yabai

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

    # java...?
    # openjdk
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

      hme = "home-manager edit";
      hms = "home-manager switch";

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

      love = "$HOME/love2d/love.app/Contents/MacOS/love";
    };

    plugins = [
      {
        name = "zsh-vim-mode";
        file = "zsh-vim-mode.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "softmoth";
          repo = "zsh-vim-mode";
          rev = "1fb4fec7c38815e55bc1b33e7c2136069278c798";
          sha256 = "1dxi18cpvbc96jl6w6j8r6zwpz8brjrnkl4kp8x1lzzariwm25sd";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.28";
          sha256 = "106s7k9n7ssmgybh0kvdb8359f3rz60gfvxjxnxb4fg5gf1fs088";
        };
      }
    ];
  };

  programs.tmux = { enable = true; };

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

  programs.neovim = {
    enable = true;

    extraConfig = builtins.readFile ~/dotfiles/conf/nvim/.vimrc;

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

  # xdg.configFile."alacritty/light.yml".text = let
  #   lightColors = {
  #     colors = {
  #       primary.foreground = "#080807";
  #       primary.background = "#faeed7";

  #       normal = {
  #         black = "#faeed7";
  #         red = "#423730";
  #         green = "#585c4c";
  #         yellow = "#30261b";
  #         blue = "#080807";
  #         magenta = "#080807";
  #         cyan = "#080807";
  #         white = "#080807";
  #       };

  #       bright = {
  #         black = "#c9bfad";
  #         red = "#bf9d88";
  #         green = "#9da488";
  #         yellow = "#d1a47f";
  #         blue = "#080807";
  #         magenta = "#080807";
  #         cyan = "#080807";
  #         white = "#080807";
  #       };

  #       indexed_colors = [
  #         {
  #           index = 16;
  #           color = "#f2e6d0";
  #         }
  #         {
  #           index = 17;
  #           color = "#ebdfca";
  #         }
  #         {
  #           index = 18;
  #           color = "#e3d7c3";
  #         }
  #         {
  #           index = 19;
  #           color = "#dbd0bd";
  #         }
  #         {
  #           index = 20;
  #           color = "#d4c9b6";
  #         }
  #       ];
  #     };
  #   };
  # in builtins.replaceStrings [ "\\\\" ] [ "\\" ]
  # (builtins.toJSON (config.programs.alacritty.settings // lightColors));

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
}

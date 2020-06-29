{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "20.03";

  home.packages = with pkgs; [
    curl
    direnv
    fasd
    fswatch
    gitAndTools.diff-so-fancy
    gnupg
    htop
    niv
    reattach-to-user-namespace
    ripgrep
    shellcheck
    tmux
    wget

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
      YARN_BIN = "$HOME/dotfiles/bin";
    };

    envExtra = ''
      export PATH=$DOTS_BIN:$PATH
      export PATH=$DOTS_DARWIN_BIN:$PATH
      export PATH=$YARN_BIN:$PATH

      # profile zsh
      # zmodload zsh/zprof
    '';

    initExtra = ''
      source $HOME/dev/repo/private/puck/puck.zsh

      eval "$(fasd --init auto)"

      eval "$(fnm env --multi)"

      eval "$(direnv hook zsh)"

      eval $(opam env)

      is_in_git_repo() {
        git rev-parse HEAD > /dev/null 2>&1
      }

      fzf-git-wrapper() {
        fzf --no-height --no-reverse "$@"
      }

      gf() {
        is_in_git_repo || return
        git -c color.status=always status --short |
        fzf-git-wrapper -m --ansi --nth 2..,.. \
          --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //'
      }

      gb() {
        is_in_git_repo || return
        git branch -a --color=always | grep -v '/HEAD\s' | sort |
        fzf-git-wrapper --ansi --multi --tac --preview-window right:70% \
          --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
        sed 's/^..//' | cut -d' ' -f1 |
        sed 's#^remotes/##'
      }

      gt() {
        is_in_git_repo || return
        git tag --sort -version:refname |
        fzf-git-wrapper --multi --preview-window right:70% \
          --preview 'git show --color=always {} | head -'$LINES
      }

      gh() {
        is_in_git_repo || return
        git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        fzf-git-wrapper --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
          --header 'Press CTRL-S to toggle sort' \
          --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
        grep -o "[a-f0-9]\{7,\}"
      }

      gr() {
        is_in_git_repo || return
        git remote -v | awk '{print $1 "\t" $2}' | uniq |
        fzf-git-wrapper --tac \
          --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
        cut -d$'\t' -f1
      }

      join-lines() {
        local item
        while read item; do
          echo -n "''${(q) item} "
        done
      }

      bind-git-helper() {
        local char
        for c in $@; do
          eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
          eval "zle -N fzf-g$c-widget"
          eval "bindkey '^g^$c' fzf-g$c-widget"
        done
      }

      bind-git-helper f b t r h
      unset -f bind-git-helper

      # profile zsh
      # zprof
    '';

    shellAliases = {
      ":q" = "tmux kill-pane";

      perf = "for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done";

      hme = "home-manager edit";
      hms = "home-manager switch";

      v = "nvim";
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

    plugins = [
      # {
      #   name = "puck";
      #   file = "puck.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "p1xelHer0";
      #     repo = "puck";
      #     rev = "";
      #     sha256 = "";
      #   };
      # }
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
      # {
      #   name = "fast-syntax-highlighting";
      #   file = "fast-syntax-highlighting.plugin.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zdharma";
      #     repo = "fast-syntax-highlighting";
      #     rev = "v1.28";
      #     sha256 = "106s7k9n7ssmgybh0kvdb8359f3rz60gfvxjxnxb4fg5gf1fs088";
      #   };
      # }
    ];
  };

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding.x = 30;
        padding.y = 30;

        decorations = "buttonless";
        startup_mode = "Windowed";
      };

      scrolling.history = 0;
      live_config_reload = true;
      selection.save_to_clipboard = true;
      mouse.hide_when_typing = true;
      visual_bell.duration = 0;
      draw_bold_text_with_bright_colors = true;

      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      font = {
        size = 18;

        normal = {
          family = "Iosevka Term";
          style = "Regular";
        };

        bold = {
          family = "Iosevka Term";
          style = "Bold";
        };

        italic = {
          family = "Iosevka Term";
          style = "Italic";
        };

        offset.x = 0;
        offset.y = 0;

        glyph_offset.x = 0;
        glyph_offset.y = 0;

        use_thin_strokes = true;
      };

      colors = {
        primary.background = "0x090803";
        primary.foreground = "0xdfd1be";

        cursor.cursor = "0xdfd1be";

        normal = {
          black = "0x090803";
          red = "0x936D16";
          green = "0x89765F";
          yellow = "0xCAA235";
          blue = "0xA48E6A";
          magenta = "0x768286";
          cyan = "0xA6A39B";
          white = "0xdfd1be";
        };

        bright = {
          black = "0x9c9285";
          red = "0x936D16";
          green = "0x89765F";
          yellow = "0xCAA235";
          blue = "0xA48E6A";
          magenta = "0x768286";
          cyan = "0xA6A39B";
          white = "0xdfd1be";
        };

        indexed_colors = [
          {
            index = 16;
            color = "0x1E2027";
          }
          {
            index = 17;
            color = "0x2A2C32";
          }
          {
            index = 18;
            color = "0x37373C";
          }
          {
            index = 19;
            color = "0x434347";
          }
          {
            index = 20;
            color = "0x4F4E51";
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

  programs.fzf = {
    enable = true;

    enableZshIntegration = true;

    defaultCommand = "rg --files --hidden --follow 2> /dev/null";
    defaultOptions = [''
      --color fg:7,bg:0,hl:3,fg+:4,bg+:0,hl+:3,info:2
      --color prompt:6,spinner:4,pointer:3,marker:3,header:2
      --no-height --no-reverse
    ''];

    fileWidgetCommand = "rg --files --hidden --follow 2> /dev/null";
    fileWidgetOptions = [
      "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
    ];

    changeDirWidgetCommand = "rg --files --hidden --follow 2> /dev/null";
    changeDirWidgetOptions = [ ];

    historyWidgetCommand = "";
    historyWidgetOptions = [ ];
  };

  programs.neovim = {
    enable = true;

    extraConfig = builtins.readFile ~/dotfiles/conf/nvim/.vimrc;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

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
}

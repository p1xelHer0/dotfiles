{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "20.03";

  home.packages = with pkgs; [
    curl
    direnv
    fasd
    fzf
    gitAndTools.diff-so-fancy
    gnupg
    htop
    niv
    reattach-to-user-namespace
    ripgrep
    shellcheck
    tmux
    wget
    zsh

    # keyboards
    dfu-util

    # window manager
    skhd
    yabai

    # nix
    nixfmt
    rnix-lsp

    # haskell
    cabal-install
    stack

    # ocaml
    bs-platform
    opam

    # rust
    rustup
  ];

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "vicmd";

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
    '';

    initExtra = ''
      if [[ $(uname) == "Darwin" ]]; then
        DARWIN=true
      fi

      # =============================================================================
      # settings {{{
      # =============================================================================

      # theme
      ZSH_THEME=puck

      # use the maximum amount of file descriptors
      ulimit -n 24576

      export LC_ALL=en_US.UTF-8


      # }}}
      # =============================================================================
      # oh-my-zsh {{{
      # =============================================================================

      export ZSH=$HOME/.oh-my-zsh


      # }}}
      # =============================================================================
      # $PATH {{{
      # =============================================================================

      # dotfile scripts
      export DOT_SCRIPTS=$HOME/dotfiles/bin

      # Yarn
      export YARN_BIN=$HOME/.yarn/bin

      # Rust
      # export CARGO_HOME=$HOME/.cargo


      # set $PATH
      export PATH=$DOT_SCRIPTS:$PATH

      export PATH=$YARN_BIN:$PATH

      # export PATH=$STACK_PACKAGES:$PATH

      # export PATH=$HASKELL_IDE_ENGINE:$PATH

      # export PATH=$CARGO_HOME:$PATH

      # -----------------------------------------------------------------------------
      # macOS $PATH
      # -----------------------------------------------------------------------------

      if [[ -n "$DARWIN" ]]; then
        # macOS dotfile scripts
        export MACOS_DOT_SCRIPTS=$HOME/dotfiles/bin/_darwin

        # clang
        # export CLANG=/usr/local/opt/llvm/bin

        # React Native
        # export REACT_DEBUGGER="unset ELECTRON_RUN_AS_NODE && open -g 'rndebugger://set-debugger-loc?port=19001' ||" yarn start

        # xcode simctl is needed for react-native emulator
        # export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer/

        # Mono
        # export MONO_ROOT=/Library/Frameworks/Mono.framework/Versions/Current/bin

        # Android
        # export ANT_HOME=/usr/local/opt/ant
        # export MAVEN_HOME=/usr/local/opt/maven
        # export GRADLE_HOME=/usr/local/opt/gradle
        # export ANDROID_HOME=/usr/local/opt/android-sdk
        # export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

        # set $PATH
        export PATH=$MACOS_DOT_SCRIPTS:$PATH

        export PATH="/usr/local/sbin:$PATH"

        # export PATH=$CLANG:$PATH

        # export PATH=$STACK_PACKAGES:$PATH

        # export PATH=$REACT_NATIVE_HOME:$PATH

        # export PATH=$MONO_ROOT:$PATH


        # export PATH=$ANT_HOME/bin:$PATH
        # export PATH=$MAVEN_HOME/bin:$PATH
        # export PATH=$GRADLE_HOME/bin:$PATH

        # export PATH=$ANDROID_HOME/tools:$PATH
        # export PATH=$ANDROID_HOME/tools/bin:$PATH
        # export PATH=$ANDROID_HOME/platform-tools:$PATH
        # export PATH=$ANDROID_HOME/build-tools/23.0.1:$PATH

      # -----------------------------------------------------------------------------
      # Linux $PATH
      # -----------------------------------------------------------------------------
      else
        # Linux dotfile scripts
        export LINUX_DOT_SCRIPTS=$HOME/dotfiles/bin/linux

        # set $PATH
        export PATH=$LINUX_DOT_SCRIPTS:$PATH
      fi


      # }}}
      # =============================================================================
      # source and eval {{{
      # =============================================================================

      # aliases
      source $HOME/dotfiles/conf/alias/.alias

      if [[ -n "$DARWIN" ]]; then
        source $HOME/dotfiles/conf/_darwin/alias/.alias
      else
        source $HOME/dotfiles/conf/_arch/alias/.alias
      fi

      # fasd
      if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi

      # fnm
      eval "$(fnm env --multi)"

      # npm tab completion
      . <(npm completion)

      # oh-my-zsh
      source $ZSH/oh-my-zsh.sh

      # rustup
      # source $CARGO_HOME/env

      # lorri direnv niv
      eval "$(direnv hook zsh)"


      # }}}
      # =============================================================================
      # fzf {{{
      # =============================================================================

      # default options
      # colors
      # fullscreen
      export FZF_DEFAULT_OPTS='
        --color fg:7,bg:0,hl:3,fg+:4,bg+:0,hl+:3,info:2
        --color prompt:6,spinner:4,pointer:3,marker:3,header:2
        --no-height --no-reverse
      '

      # make fzf use ripgrep
      # --files: List files that would be searched but do not search
      # --no-ignore: Do not respect .gitignore, etc...
      # --hidden: Search hidden files and folders
      # --follow: Follow symlinks
      export FZF_DEFAULT_COMMAND='rg --files --hidden --follow 2> /dev/null'

      # use the same command with <C-t>
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

      # preview contents of file
      # Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
      # see https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
      export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

      # use the same command with <A-c>
      export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

      [ -f $HOME/.nix-profile/share/fzf/key-bindings.zsh ] && source $HOME/.nix-profile/share/fzf/key-bindings.zsh

      # }}}

      # =============================================================================
      # nix {{{
      # =============================================================================

      # added by Nix installer
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi


      # }}}
    '';

    shellAliases = {
      # lazy
      v = "nvim";

      # vim with esy packages
      ev = "esy nvim";

      # open dotfiles in editor
      dots = "cd $HOME/dotfiles && vim";

      # open Neovim config
      vimrc = "vim $HOME/dotfiles/conf/neovim";

      # fzf -> open in vim
      vf = "vim $(fzf)";

      # open zsh config
      zshrc = "vim $HOME/dotfiles/conf/zsh/.zshrc";

      # open tmux config
      tmuxrc = "vim $HOME/dotfiles/conf/tmux/.tmux.conf";

      # open tmux split with swap files
      swap = "tmux split-window 'cd $HOME/.local/share/nvim/swap && nvim'";

      # reload shell
      rl = "exec zsh";

      # list npm modules global/local
      ng = "npm list -g --depth=0 2>/dev/null";
      nl = "npm list --depth=0 2>/dev/null";

      # show ip and local ip
      ip = "dig +short myip.opendns.com @resolver1.opendns.com";
      ipl =
        "ifconfig | grep -Eo 'inet (addr:)?([0-9]*.){3}[0-9]*' | grep -Eo '([0-9]*.){3}[0-9]*' | grep -v '127.0.0.1'";

      # exclude macOS specific files in ZIP archives
      zip = "zip -x *.DS_Store -x *__MACOSX* -x *.AppleDouble*";

      # recursively remove Apple meta files
      cleanupds = "find . -type f -name '*.DS_Store' -ls -exec /bin/rm {} ;";
      cleanupad = "find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} ;";

      # free WiFi
      freewifi =
        "sudo ifconfig en0 ether `openssl rand -hex 6 | sed 's/(..)/1:/g; s/.$//' `";

      rwal =
        "clear && wal -i $HOME/dropbox/walls -o $HOME/dotfiles/bin/_darwin/wal-set";
      lrwal =
        "clear && wal -l -i $HOME/dropbox/walls -o $HOME/dotfiles/bin/_darwin/wal-set";
    };

    oh-my-zsh = {
      enable = true;
      theme = "puck";
    };

    plugins = [
      {
        name = "puck";
        file = "puck.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "p1xelHer0";
          repo = "puck";
          rev = "da39a97292365c187c1eb778d8611a5ce46ad41c";
          sha256 = "10m5y8y69nk4qnmplsjyk3s8j0iywjbwz5amw615bx7i99k0sqry";
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
      # {
      #   name = "vi-mode";
      #   file = "/plugins/vi-mode/vi-mode.plugin.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "ohmyzsh";
      #     repo = "ohmyzsh";
      #     rev = "3c777ebf1b24826363bea6bc29afa9ba038b10e8";
      #     sha256 = "0pny3sadwn4v47d6alpzbffzics9xmpkwjnl8qb81lv1aipif8p3";
      #   };
      # }
      {
        name = "autopair";
        file = "autopair.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "4039bf142ac6d264decc1eb7937a11b292e65e24";
          sha256 = "02pf87aiyglwwg7asm8mnbf9b2bcm82pyi1cj50yj74z4kwil6d1";
        };
      }
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

  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ~/dotfiles/conf/nvim/.vimrc;

    plugins = with pkgs.vimPlugins; [
      ale
      editorconfig-vim
      fzf-vim
      neoformat
      nerdtree
      nerdtree-git-plugin
      supertab
      vim-commentary
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

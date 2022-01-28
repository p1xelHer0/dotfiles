{ config, pkgs, ... }:

{
  home.username = "pontus";
  home.homeDirectory = "/home/pontus";

  home.stateVersion = "21.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    p7zip
    curl
    fasd
    gitAndTools.diff-so-fancy
    lazygit
    jq
    ripgrep
    tree-sitter
    wget

    # Lua
    stylua

    # nix
    nixfmt
    rnix-lsp

    # Web
    fnm
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    # nodePackages.typescript
    # nodePackages.typescript-language-server

    # Azure
    azure-cli
  ];

  programs.zsh = {
    enable = true;

    enableAutosuggestions = false;
    enableCompletion = true;

    sessionVariables = {
      EDITOR = "nvim";
      LC_ALL = "en_US.UTF-8";

      DOTS_BIN = "$HOME/dotfiles/bin";
    };

    envExtra = "";

    initExtra = ''
      export PATH=$DOTS_BIN:$PATH
      export RPROMPT=""
      source "$DOTS_BIN/fzf_git"
      eval "$(fasd --init auto)"
      eval "$(fnm env)"
    '';

    shellAliases = {
      "l" = "clear";
      ":q" = "tmux kill-pane";


      v = "nvim";
      vim = "nvim";
      vf = "nvim $(fzf)";

      dots = "cd $HOME/dotfiles && nvim";

      dre = "nvim ~/dotfiles/home.nix";
      drs = "home-manager switch -f ~/dotfiles/home.nix";

      rl = "exec zsh";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
    };

    plugins = [ ];
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
        $username$hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$nodejs$nix_shell$cmd_duration$jobs$time$status
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
        format = "[$symbol($version )]($style)";
        symbol = "[node](green)";
      };

      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        symbol = "[nix](blue)";
      };
    };
  };

  programs.tmux = {
    enable = true;

    extraConfig = builtins.readFile ~/dotfiles/.config/tmux/tmux.conf;
  };

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

    historyWidgetOptions = [ ];
  };

  programs.neovim = {
    enable = true;

    extraConfig = builtins.readFile ~/dotfiles/.config/nvim/init.vim;

    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [ packer-nvim ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Pontus Nagy";
    userEmail = "pontus.nagy@aspia.se";
    includes = [{ path = "~/dotfiles/.config/git/.gitconfig"; }];
  };
}

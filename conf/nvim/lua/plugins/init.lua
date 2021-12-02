require "plugins.statusline"

return require("packer").startup(function(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    run = ":TSUpdate",
  }
  -- use {
  --   "nvim-treesitter/playground",
  --   requires = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   run = ":TSInstall query",
  -- }

  use {
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "telescope-frecency.nvim",
        "telescope-fzf-native.nvim",
      },
      wants = {
        "popup.nvim",
        "plenary.nvim",
        "telescope-frecency.nvim",
        "telescope-fzf-native.nvim",
      },
      config = [[require('plugins.telescope')]],
      cmd = "Telescope",
      module = "telescope",
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      after = "telescope.nvim",
      requires = "tami5/sql.nvim",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").config {}
      require("lspconfig")["null-ls"].setup {}
    end,
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }

  use {
    "folke/trouble.nvim",
    requiress = "folke/lsp-colors.nvim",
    config = [[require('plugins.trouble')]],
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    },
    config = [[require('plugins.cmp')]],
    event = "InsertEnter *",
  }

  use { "sbdchd/neoformat" }
  use {
    "terrortylor/nvim-comment",
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("nvim_comment").setup {
        hook = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      }
    end,
  }
  use { "tpope/vim-repeat" }
  use { "AndrewRadev/switch.vim" }
  use { "junegunn/vim-easy-align" }

  use { "christoomey/vim-tmux-navigator" }

  use { "nvim-lua/lsp_extensions.nvim" }
  use { "neovim/nvim-lspconfig" }

  use { "mfussenegger/nvim-dap" }

  use { "glepnir/galaxyline.nvim" }
  use {
    "kyazdani42/nvim-tree.lua",
    config = [[require('plugins.nvim-tree')]],
  }
  use { "auwsmit/vim-active-numbers" }
  use {
    "folke/zen-mode.nvim",
    config = [[require('plugins.zen-mode')]],
  }
  use {
    "folke/twilight.nvim",
    config = [[require('plugins.twilight')]],
  }
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = [[require('plugins.gitsigns')]],
  }

  use {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup {}
    end,
  }

  use {
    "plasticboy/vim-markdown",
    requires = { "godlygeek/tabular", before = "plasticboy/vim-markdown" },
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
  }
  use { "dpelle/vim-LanguageTool" }
  use { "Ron89/thesaurus_query.vim" }
  use { "preservim/vim-wordy" }
  use { "dbmrq/vim-ditto" }
  use { "reedes/vim-lexical" }
  use { "reedes/vim-litecorrect" }

  use { "elzr/vim-json", ft = "json" }

  use { "pangloss/vim-javascript", ft = "javascript" }
  use { "leafgarland/typescript-vim", ft = "typescript" }

  use { "ocaml/vim-ocaml", ft = "ocaml" }
  use { "ocaml/merlin", ft = "ocaml" }

  use { "rescript-lang/vim-rescript", ft = "rescript" }

  use { "rust-lang/rust.vim", ft = "rust" }
  use { "simrat39/rust-tools.nvim", ft = "rust" }

  use { "neovimhaskell/haskell-vim", ft = "haskell" }

  use { "jparise/vim-graphql" }

  use { "LnL7/vim-nix", ft = "nix" }
end)

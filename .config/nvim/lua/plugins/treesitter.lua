local ensure_installed = {
  "bash",
  "c",
  "clojure",
  "commonlisp",
  "cpp",
  "css",
  "elixir",
  "elm",
  "erlang",
  "fennel",
  "haskell",
  "html",
  "http",
  "janet_simple",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "jsonc",
  "kdl",
  "llvm",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "ocaml",
  "ocaml_interface",
  "ocamllex",
  "python",
  "query",
  "racket",
  "regex",
  "rust",
  "scheme",
  "scss",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    build = ":TSUpdate",
    event = function()
      return require("internal.events").lazyFile
    end,

    opts = {
      ensure_installed = ensure_installed,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true,
      },
      refactor = {
        navigation = {
          enable = true,
          keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>",
          },
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "andymass/vim-matchup",
    event = function()
      return require("internal.events").lazyFile
    end,
    opts = {},
    init = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = function()
      return require("internal.events").lazyFile
    end,
    opts = {},
  },

  {
    "m-demare/hlargs.nvim",
    event = function()
      return require("internal.events").lazyFile
    end,
    config = function(_, opts)
      vim.api.nvim_create_augroup("LspAttach_hlargs", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_hlargs",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local caps = client.server_capabilities
          if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
            require("hlargs").disable_buf(args.buf)
          end
        end,
      })

      require("hlargs").setup(opts)
    end,
  },

  {
    enabled = false,
    "nvim-neotest/neotest",
    dependencies = {
      "rouge8/neotest-rust",
    },
    config = function()
      require("keymap.neotest").setup()
      require("neotest").setup({
        adapters = {
          require("neotest-rust")({
            args = { "--no-capture" },
          }),
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = function()
      return require("internal.events").lazyFile
    end,
    config = true,
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    event = function()
      return require("internal.events").lazyFile
    end,
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },

  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
}

return M

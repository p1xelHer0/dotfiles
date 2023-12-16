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
      "nvim-treesitter/nvim-treesitter-textobjects",
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
      textobjects = {
        --   select = {
        --     enable = true,
        --
        --     -- Automatically jump forward to textobj, similar to targets.vim
        --     lookahead = true,
        --
        --     keymaps = {
        --       -- You can use the capture groups defined in textobjects.scm
        --       ["af"] = "@function.outer",
        --       ["if"] = "@function.inner",
        --       ["ac"] = "@class.outer",
        --       -- You can optionally set descriptions to the mappings (used in the desc parameter of
        --       -- nvim_buf_set_keymap) which plugins like which-key display
        --       ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        --       -- You can also use captures from other query groups like `locals.scm`
        --       ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        --     },
        --     -- You can choose the select mode (default is charwise 'v')
        --     --
        --     -- Can also be a function which gets passed a table with the keys
        --     -- * query_string: eg '@function.inner'
        --     -- * method: eg 'v' or 'o'
        --     -- and should return the mode ('v', 'V', or '<c-v>') or a table
        --     -- mapping query_strings to modes.
        --     selection_modes = {
        --       ["@parameter.outer"] = "v", -- charwise
        --       ["@function.outer"] = "V", -- linewise
        --       ["@class.outer"] = "<c-v>", -- blockwise
        --     },
        --     -- If you set this to `true` (default is `false`) then any textobject is
        --     -- extended to include preceding or succeeding whitespace. Succeeding
        --     -- whitespace has priority in order to act similarly to eg the built-in
        --     -- `ap`.
        --     --
        --     -- Can also be a function which gets passed a table with the keys
        --     -- * query_string: eg '@function.inner'
        --     -- * selection_mode: eg 'v'
        --     -- and should return true of false
        --     include_surrounding_whitespace = true,
        --   },
        --   swap = {
        --     enable = true,
        --     swap_next = {
        --       ["<leader>a"] = "@parameter.inner",
        --     },
        --     swap_previous = {
        --       ["<leader>A"] = "@parameter.inner",
        --     },
        --   },
        --   move = {
        --     enable = true,
        --     set_jumps = true, -- whether to set jumps in the jumplist
        --     goto_next_start = {
        --       ["]m"] = "@function.outer",
        --       ["]]"] = { query = "@class.outer", desc = "Next class start" },
        --       --
        --       -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        --       ["]o"] = "@loop.*",
        --       -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --       --
        --       -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        --       -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        --       ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        --       ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        --     },
        --     goto_next_end = {
        --       ["]M"] = "@function.outer",
        --       ["]["] = "@class.outer",
        --     },
        --     goto_previous_start = {
        --       ["[m"] = "@function.outer",
        --       ["[["] = "@class.outer",
        --     },
        --     goto_previous_end = {
        --       ["[M"] = "@function.outer",
        --       ["[]"] = "@class.outer",
        --     },
        --     -- Below will go to either the start or the end, whichever is closer.
        --     -- Use if you want more granular movements
        --     -- Make it even more gradual by adding multiple queries and regex.
        --     goto_next = {
        --       ["]d"] = "@conditional.outer",
        --     },
        --     goto_previous = {
        --       ["[d"] = "@conditional.outer",
        --     },
        --   },
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
          local capabilities = client.server_capabilities
          if capabilities.semanticTokensProvider and capabilities.semanticTokensProvider.full then
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
    opts = {
      -- highlight = {
      --   "Normal",
      --   "DiagnosticWarn",
      --   "DiagnosticHint",
      --   "DiagnosticError",
      --   "DiagnosticOk",
      --   "DiagnosticInfo",
      -- },
    },
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

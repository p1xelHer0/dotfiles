local lazy_file_event = require("base.config").lazy_file_event

local ensure_installed = {
  "bash",
  "nu",
  "make",
  "nix",
  "vim",
  "scheme",
  "c",
  "cpp",
  "odin",
  "zig",
  "rust",
  "go",
  "python",
  "lua",
  "glsl",
  "hlsl",
  "wgsl",
  "html",
  "css",
  "scss",
  "javascript",
  "typescript",
  "elm",
  "json",
  "yaml",
  "toml",
  "markdown",
}

local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = lazy_file_event,
    opts = {
      ensure_installed = ensure_installed,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]]"] = { query = "@class.outer", desc = "Next class start" },

          ["]o"] = { query = { "@loop.inner", "@loop.outer" } },

          ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
        -- Below will go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        -- Make it even more gradual by adding multiple queries and regex.
        goto_next = {
          ["]d"] = "@conditional.outer",
        },
        goto_previous = {
          ["[d"] = "@conditional.outer",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
    config = function(_, opts)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { noremap = true, desc = "Tree-sitter: " .. desc })
      end

      map("<Leader>0", ":Inspect<CR>", "inspect")

      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "andymass/vim-matchup",
    event = lazy_file_event,
    opts = {},
    init = function()
      -- vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = lazy_file_event,
    opts = {},
  },
}

return M

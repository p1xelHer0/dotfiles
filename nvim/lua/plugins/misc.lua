local options = require("base.config").get_options()
local lazy_file_event = require("base.config").lazy_file_event

local M = {
  {
    dir = "~/code/codeberg/p1xelHer0/mibo",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) vim.cmd.colorscheme("mibo") end,
  },

  {
    dir = "~/dotfiles/nvim/lua/colors",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      -- vim.cmd.colorscheme("colors")
    end,
  },

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function() end,
  },

  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) require("everforest").setup(opts) end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        harpoon = true,
        fidget = true,
      },
    },
    config = function(_, opts) end,
  },

  {
    url = "https://git.liten.app/krig/filth-theme",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) vim.o.background = "dark" end,
  },

  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) end,
  },

  --

  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    opts = {},
    config = function(_, opts)
      local lualine = require("lualine")
      lualine.setup(opts)
    end,
  },

  --

  {
    "NMAC427/guess-indent.nvim",
    event = lazy_file_event,
  },

  {
    "nvim-mini/mini.pairs",
    enabled = false,
    version = false,
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-mini/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-mini/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {},
  },

  { "tpope/vim-repeat" },

  --

  {
    "folke/todo-comments.nvim",
    event = lazy_file_event,

    -- FIXME: Testing FIXME
    -- TODO:  Testing TODO
    -- WARN:  Testing WARN
    -- PERF:  Testing PERF
    -- HACK:  Testing HACK
    -- INFO:  Testing INFO
    -- TEST:  Testing TEST

    opts = {
      keywords = {
        FIX = { icon = "!" },
        TODO = { icon = "*" },
        HACK = { icon = "/" },
        WARN = { icon = "w" },
        PERF = { icon = ">" },
        NOTE = { icon = "i" },
        TEST = { icon = "t" },
      },
      -- colors = {
      --   error = { "DiagnosticError" },
      --   warning = { "DiagnosticWarn" },
      --   info = { "DiagnosticInfo" },
      --   hint = { "DiagnosticHint" },
      --   default = { "Identifier" },
      --   test = { "Identifier" },
      --   todo = { "DiagnosticInfo" },
      -- },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = lazy_file_event,
    opts = {
      user_default_options = {
        names = false,
        mode = "background",
      },
    },
    config = function(_, opts)
      local nvim_colorizer_group = vim.api.nvim_create_augroup("plugins.nvim-colorizer", {})
      local attach_colorize_on_pattern = function(pattern)
        vim.api.nvim_create_autocmd("BufEnter", {
          group = nvim_colorizer_group,
          pattern = pattern,
          callback = function(event) require("colorizer").attach_to_buffer(event.buf, opts.user_default_options) end,
        })
      end
      attach_colorize_on_pattern("**/ghostty/themes/**")
      attach_colorize_on_pattern("colors.lua")
      attach_colorize_on_pattern("palette.lua")
      attach_colorize_on_pattern("mibo.toml")
      require("colorizer").setup(opts)
    end,
  },

  --

  {
    "tpope/vim-projectionist",
    event = lazy_file_event,
    keys = {
      {
        "<Leader>p",
        "<CMD>A<CR>",
        mode = "n",
        desc = "Projectionist: alternative file",
      },
    },
    opts = {
      ["*"] = {
        -- C
        ["*.c"] = {
          alternate = "{}.h",
        },
        ["*.h"] = {
          alternate = "{}.c",
        },

        -- sokol_shdc
        ["**.glsl"] = {
          alternate = "{}.glsl.h",
        },
        ["**.glsl.odin"] = {
          alternate = "{}.glsl",
        },

        -- Elm
        ["app/elm/App/*Service.elm"] = {
          alternate = "app/elm/App/{}.elm",
        },
        ["app/elm/App/Pages/*.elm"] = {
          alternate = "app/elm/App/Pages/{}Service.elm",
        },
        ["app/elm/App/Fullscreens/*.elm"] = {
          alternate = "app/elm/App/Fullscreens/{}Service.elm",
        },
        ["app/elm/App/Services/*.elm"] = {
          alternate = "app/elm/App/Services/{}Service.elm",
        },

        -- OCaml
        ["**.mli"] = {
          alternate = "{}.ml",
        },
        ["**.ml"] = {
          alternate = "{}.mli",
        },
      },

      -- Gerbil
      ["gerbil.pkg"] = {
        ["**-test.ss"] = {
          alternate = "{}.ss",
        },
        ["**.ss"] = {
          alternate = "{}-test.ss",
        },
      },
    },
    config = function(_, opts) vim.g.projectionist_heuristics = opts end,
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        cmd = {
          "DiffviewClose",
          "DiffviewFileHistory",
          "DiffviewFocusFiles",
          "DiffviewLog",
          "DiffviewOpen",
          "DiffviewRefresh",
          "DiffviewToggleFiles",
        },
        config = true,
        opts = {
          use_icons = false,
        },
      },
    },
    keys = {
      {
        "<Leader>G",
        function() require("neogit").open() end,
      },
    },
    opts = {
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
    },
  },

  {
    "nvim-mini/mini.diff",
    version = false,
    event = lazy_file_event,
    opts = {
      view = {
        style = "sign",
        signs = { add = "▌", change = "▌", delete = "▌" },
      },
      mappings = {
        goto_prev = "[c",
        goto_next = "]c",
        goto_first = "[C",
        goto_last = "]C",
      },
    },
  },

  --

  {
    "nvim-mini/mini.comment",
    version = false,
    event = lazy_file_event,
    opts = {},
  },

  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = lazy_file_event,
    opts = {
      symbol = "│",
    },
  },

  --

  {
    "nvimtools/none-ls.nvim",
    event = lazy_file_event,
    opts = function(_, _)
      local null_ls = require("null-ls")
      return {
        null_ls.builtins.diagnostics.selene,
      }
    end,
    config = function(_, opts) require("null-ls").setup(opts) end,
  },

  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = lazy_file_event,
    keys = {
      {
        "<Leader><Leader>f",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        elm = { "elm_format" },
        go = { "gofumpt" },
        toml = { "taplo" },
        zig = { "zigfmt" },
        python = { "ruff" },
        javascript = { "biome" },
        typescript = { "biome" },
        ["*"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = function() return { timeout_ms = 500, lsp_format = "fallback" } end,
    },
  },

  --

  {
    "stevearc/oil.nvim",
    keys = {
      {
        "<Leader>n",
        "<CMD>Oil<CR>",
        desc = "Open parent directory",
      },
    },
    opts = {},
    lazy = false,
  },

  --

  { "christoomey/vim-tmux-navigator" },

  --

  {
    "j-hui/fidget.nvim",
    event = lazy_file_event,
    opts = {
      window = {
        winblend = options.blend,
      },
    },
  },

  {
    "folke/flash.nvim",
    event = lazy_file_event,
    opts = {},
    keys = {
      -- stylua: ignore start
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash: jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash: Treesitter" },
      { "r", mode = {           "o" }, function() require("flash").remote() end,            desc = "Flash: remote" },
      { "R", mode = {      "x", "o" }, function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },

      { "<C-s>", mode = "c", function() require("flash").toggle() end,                      desc = "Flash: Toggle Search" },
      -- stylua: ignore end
    },
  },

  --

  {
    "olexsmir/gopher.nvim",
    config = true,
    ft = "go",
  },

  --

  { "nvim-lua/plenary.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
}

return M

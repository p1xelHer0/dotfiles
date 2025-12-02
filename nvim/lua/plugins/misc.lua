local lazy_file_event = require("base.config").lazy_file_event

local M = {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {},
    lazy = false,
    priority = 1000,
  },

  {
    dir = "~/dotfiles/nvim/lua/colors",
    lazy = false,
    priority = 1000,
  },

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("zenbones")
    end,
  },

  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("everforest").setup(opts)
      -- vim.cmd.colorscheme("everforest")
    end,
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
    "echasnovski/mini.pairs",
    enabled = false,
    version = false,
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {},
  },

  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
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
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    opts = {
      user_default_options = {
        names = false,
        mode = "background",
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "**/.config/alacritty/*.toml",
        callback = function()
          require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
        end,
      })

      require("colorizer").setup(opts)
    end,
  },

  --

  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    keys = {
      {
        "<Leader>t",
        function()
          require("toggleterm").toggle()
        end,
        desc = "ToggleTerm: floating",
      },
    },
    opts = function()
      local options = require("base.config").get_options()

      return {
        size = function(term)
          if term.direction == "float" then
            return 20
          end
        end,
        float_opts = {
          -- border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          winblend = options.blend,
        },
        direction = "float",
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
      }
    end,
  },

  --

  { "MagicDuck/grug-far.nvim", opts = {} },

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

        -- .env
        [".env*"] = {
          alternate = ".env{}.local",
        },
        [".env*.local"] = {
          alternate = ".env{}",
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
    config = function(_, opts)
      vim.g.projectionist_heuristics = opts
    end,
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
        function()
          require("neogit").open()
        end,
      },
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
    config = function(_, opts)
      require("neogit").setup(opts)
    end,
  },

  {
    "echasnovski/mini.diff",
    version = false,
    event = lazy_file_event,
    opts = {
      view = {
        style = "sign",
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
    "echasnovski/mini.comment",
    version = false,
    event = lazy_file_event,
    opts = {},
  },

  --

  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = lazy_file_event,
    keys = {
      {
        "<Leader><Leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
        elm = { "elm_format" },
        go = { "gofumpt" },
        javascript = { "biome" },
        typescript = { "biome" },
        ["*"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = function()
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
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

  { "LunarVim/bigfile.nvim" },

  --

  {
    "j-hui/fidget.nvim",
    event = lazy_file_event,
    opts = {},
  },

  {
    "folke/flash.nvim",
    event = lazy_file_event,
    opts = {},
    keys = {
      -- stylua: ignore start
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash: jump" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash: Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Flash: remote" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Flash: Toggle Search" },
      -- stylua: ignore end
    },
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

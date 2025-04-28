local lazy_file_event = require("base.config").lazy_file_event

local M = {
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
    "NMAC427/guess-indent.nvim",
    event = lazy_file_event,
  },

  {
    "echasnovski/mini.pairs",
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
  },

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

  { "MagicDuck/grug-far.nvim", opts = {} },

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
        telescope = true,
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
  {
    "echasnovski/mini.comment",
    version = false,
    event = lazy_file_event,
    opts = {},
  },

  -- formatting
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
        javascript = { "biome" },
        typescript = { "biome" },
        ["*"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = function()
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    },
  },

  { "christoomey/vim-tmux-navigator" },

  -- deps and dev
  { "nvim-lua/plenary.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        {
          path = "${3rd}/luv/library",
          words = { "vim%.uv" },
        },
      },
    },
  },
}

return M

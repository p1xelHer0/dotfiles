local O = require("p1xelHer0.config").options()
local lazy_file_event = require("p1xelHer0.config").lazy_file_event

local M = {

  {
    "nvim-mini/mini.pairs",
    version = false,
    event = lazy_file_event,
    opts = {},
  },

  {
    "nvim-mini/mini.ai",
    version = false,
    event = lazy_file_event,
    opts = {},
  },

  {
    "nvim-mini/mini.surround",
    version = false,
    event = lazy_file_event,
    opts = {},
  },

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

  {
    "NMAC427/guess-indent.nvim",
    event = lazy_file_event,
  },

  {
    "nvim-mini/mini.diff",
    version = false,
    event = lazy_file_event,
    opts = {
      view = {
        style = "sign",
        signs = { add = "▎", change = "▎", delete = "▎" },
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
    "tpope/vim-repeat",
    event = lazy_file_event,
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

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon.setup(opts)

      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { desc = "Harpoon: " .. desc })
      end

      map("<Leader>a", function() harpoon:list():add() end, "Add")
      map("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "toggle quick menu")

      for i = 1, 9 do
        map("<Leader>" .. i, function() harpoon:list():select(i) end, "select " .. i)
      end
    end,
  },

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

        -- C - sokol_shdc
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

        -- Odin
        ["**.odin"] = {
          alternate = "{}_test.odin",
        },
        ["**_test.odin"] = {
          alternate = "{}.odin",
        },

        -- OCaml
        ["**.mli"] = {
          alternate = "{}.ml",
        },
        ["**.ml"] = {
          alternate = "{}.mli",
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
    "j-hui/fidget.nvim",
    event = lazy_file_event,
    opts = {
      window = {
        winblend = O.blend,
      },
    },
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

  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },

  { "nvim-lua/plenary.nvim" },
}

return M

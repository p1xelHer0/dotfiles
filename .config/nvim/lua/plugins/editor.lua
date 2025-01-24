local M = {
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "tpope/vim-abolish",
    event = "VeryLazy",
  },

  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  {
    "teranex/jk-jumps.vim",
    event = "VeryLazy",
  },

  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
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
      require("keymap.projectionist").setup()
    end,
  },

  {
    "jiaoshijie/undotree",
    keys = {
      {
        "<Leader>U",
        function()
          require("undotree").toggle()
        end,
      },
    },
    opts = {},
  },

  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = function()
      return require("internal.events").lazyFile
    end,
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
        elm = { "elm_format" },
        javascript = { "biome" },
        typescript = { "biome" },
        ["*"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<Leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
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
      tailwind = true,
    },
  },

  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    cmd = {
      "TailwindColorsAttach",
      "TailwindColorsDeatach",
      "TailwindColorsRefresh",
      "TailwindColorsToggle",
    },
  },
}

return M

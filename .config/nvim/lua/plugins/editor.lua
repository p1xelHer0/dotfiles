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
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    ft = require("core.config").get_lisp_ft(),
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<C-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
    opts = {
      ["*"] = {
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
      },
      -- OCaml
      ["dune*|*.opam|esy.json"] = {
        ["**.ml"] = {
          alternate = "{}.mli",
        },
        ["**.mli"] = {
          alternate = "{}.ml",
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
    keys = {
      {
        "<Leader><Leader>f",
        function()
          require("conform").format()
        end,
      },
    },
    opts = {
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      --   quiet = true,
      -- },
      formatters_by_ft = {
        javascript = { "prettierd" },
        css = { "prettierd" },
        sass = { "prettierd" },
        scss = { "prettierd" },
        sh = { "shfmt" },
        elm = { "elm-format" },
        lua = { "stylua" },
        -- markdown = { "mdformat" },
        nix = { "nixformat" },
        ocaml = { "ocamlformat" },
        rust = { "rustfmt" },
      },
    },
    config = function(_, opts)
      opts.formatters = opts.formatters or {}
      for f, o in pairs(opts.formatters) do
        local ok, formatter = pcall(require, "conform.formatters." .. f)
        opts.formatters[f] = vim.tbl_deep_extend("force", {}, ok and formatter or {}, o)
      end

      require("conform").setup(opts)
    end,
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
    cmd = {
      "TroubleToggle",
      "Trouble",
    },
    opts = {
      severity = vim.diagnostic.severity.ERROR,
      icons = false,
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>xx", "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
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

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

local ts = "nvim-treesitter/nvim-treesitter"

local M = {
  {
    ts,
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      -- "RRethy/nvim-treesitter-textsubjects",

      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
          enable = true,
          enable_autocmd = false,
        },
        config = function(_, opts)
          require("ts_context_commentstring").setup(opts)
        end,
      },
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = ensure_installed,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      refactor = {},
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = ts,
    lazy = true,
    config = true,
  },

  {
    enabled = true,
    "windwp/nvim-ts-autotag",
    dependencies = ts,
    event = "InsertEnter",
    config = true,
  },

  {
    enabled = true,
    "windwp/nvim-autopairs",
    dependencies = {
      ts,
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local status, cmp = pcall(require, "cmp")
      if not status then
      else
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
      end
    end,
  },

  {
    enabled = true,
    "m-demare/hlargs.nvim",
    dependencies = ts,
    event = { "BufReadPost", "BufNewFile" },
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
    enabled = true,
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
    enabled = true,
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = ts,
    event = { "CursorHold", "WinScrolled" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    config = true,
  },

  {
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    dependencies = ts,
    opts = {},
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },

  {
    enabled = true,
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
}

return M

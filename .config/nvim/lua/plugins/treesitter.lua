local ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "elixir",
  "elm",
  "erlang",
  "graphql",
  "haskell",
  "html",
  "http",
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
  "regex",
  "rust",
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
      -- "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      -- "RRethy/nvim-treesitter-textsubjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    opts = {
      highlight = {
        enable = true,
        disable = function(_lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = ensure_installed,
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "gnn",
      --     node_incremental = "grn",
      --     scope_incremental = "grc",
      --     node_decremental = "grm",
      --   },
      -- },
      -- textobjects = {},
      -- textsubjects = {},
      refactor = {},
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "CursorHold", "WinScrolled" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    config = true,
  },

  {
    enabled = false,
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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

      require("hlargs.nvim").setup(opts)
    end,
  },

  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "TSPlaygroundToggle",
  },
}

return M

local M = {
  { "editorconfig/editorconfig-vim", event = "VeryLazy" },

  { "tpope/vim-repeat", event = "VeryLazy" },

  { "tpope/vim-abolish", event = "VeryLazy" },

  {
    "mbbill/undotree",
    keys = {
      {
        "<Leader>U",
        vim.cmd.UndotreeToggle,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    event = "VeryLazy",
    keys = {
      {
        "<Leader><Leader>f",
        function()
          require("conform").format()
        end,
      },
    },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        javascript = { "prettierd" },
        css = { "prettierd" },
        sass = { "prettierd" },
        scss = { "prettierd" },
        sh = { "shfmt" },
        elm = { "elm-format" },
        lua = { "stylua" },
        markdown = { "mdformat" },
        nix = { "nixformat" },
        ocaml = { "ocamlformat" },
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
    "andymass/vim-matchup",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
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

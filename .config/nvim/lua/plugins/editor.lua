local M = {
  { "editorconfig/editorconfig-vim", event = "VeryLazy" },

  { "tpope/vim-repeat", event = "VeryLazy" },

  { "tpope/vim-abolish", event = "VeryLazy" },

  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      {
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        silent = true,
        noremap = true,
      },
      {
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        silent = true,
        noremap = true,
      },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], silent = true, noremap = true },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], silent = true, noremap = true },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], silent = true, noremap = true },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], silent = true, noremap = true },
    },
    opts = {},
    config = function(_, opts)
      require("hlslens").setup(opts)
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
    config = true,
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
        quiet = true,
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
      use_diagnostic_signs = true,
      icons = false,
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

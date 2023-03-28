local M = {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "f3fora/cmp-spell",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = {
          "zbirenbaum/copilot.lua",
          config = true,
        },
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")

      local sources = {
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 5 },
        { name = "luasnip" },
        { name = "copilot" },
        { name = "path", keyword_length = 5 },
      }

      local ft = vim.o.ft
      if ft == "markdown" or ft == "txt" or ft == "none" then
        table.insert(sources, { name = "spell" })
      end

      return {
        mapping = cmp.mapping.preset.insert({
          ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
        }),
        preselect = cmp.PreselectMode.Item,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = sources,
        -- formatting = {
        --   format = require("tailwindcss-colorizer-cmp").formatter,
        -- },
        -- formatting = {
        --   format = function(entry, vim_item)
        --     local kind_icons = require("core.config").get_icons().kind_icons
        --     vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
        --     local general_icons = require("core.config").get_icons().general
        --     vim_item.menu = ({
        --       buffer = general_icons.text,
        --       luasnip = general_icons.snippet,
        --       nvim_lsp = general_icons.lsp,
        --       nvim_lua = general_icons.lua,
        --       path = general_icons.path,
        --       spell = general_icons.spell,
        --     })[entry.source.name]
        --     return vim_item
        --   end,
        -- },
        experimental = {
          ghost_text = true,
        },
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    config = function()
      local ls = require("luasnip")
      local dotfiles_dir = require("core.config").get_dotfiles_path()

      require("luasnip.loaders.from_lua").load({
        paths = { dotfiles_dir .. "/.config/nvim/lua/snippets/" },
      })

      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
    end,
    event = "InsertEnter",
  },

  {
    "windwp/nvim-autopairs",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local status, cmp = pcall(require, "cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    config = true,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = true,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = true,
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
}

return M

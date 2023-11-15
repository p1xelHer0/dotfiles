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
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")

      local sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "buffer", keyword_length = 5, group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "path", keyword_length = 5, group_index = 2 },
      }

      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          cmp.setup.buffer({ sources = { { name = "crates", group_index = 2 } } })
        end,
      })

      local ft = vim.o.ft
      if ft == "markdown" or ft == "txt" or ft == "none" then
        table.insert(sources, { name = "spell", group_index = 2 })
      end
      if ft == "lua" then
        table.insert(sources, { name = "nvim_lua", group_index = 2 })
      end

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
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
          -- ghost_text = true,
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "luasnip" },
        }, {
          { name = "gi" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function()
      local dotfiles_dir = require("core.config").get_dotfiles_path()

      require("luasnip.loaders.from_lua").load({
        paths = { dotfiles_dir .. "/.config/nvim/lua/LuaSnip/" },
      })
    end,
    keys = {
      {
        "<Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },

  {
    enabled = true,
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
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    enabled = true,
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
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
}

return M

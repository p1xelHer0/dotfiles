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
      "ray-x/cmp-treesitter",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")

      local sources = {
        {
          name = "nvim_lsp",
          group_index = 1,
          entry_filter = function(entry, ctx)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
          end,
        },
        { name = "treesitter", group_index = 1 },

        { name = "luasnip", group_index = 2 },

        { name = "path", group_index = 3 },
        { name = "buffer", group_index = 3 },
      }

      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          cmp.setup.buffer({
            sources = { { name = "crates", group_index = 1 } },
          })
        end,
      })

      local ft = vim.o.ft
      if ft == "markdown" or ft == "txt" or ft == "none" then
        table.insert(sources, { name = "spell", group_index = 1 })
      end
      if ft == "lua" then
        table.insert(sources, { name = "nvim_lua", group_index = 1 })
      end

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
        }),
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = sources,
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
    "LunarVim/bigfile.nvim",
    lazy = true,
  },
}

return M

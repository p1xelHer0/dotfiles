local config = {}

function config.nvim_lspconfig()
  require("modules.lsp.lspconfig").setup()
end

function config.lspsaga()
  require("modules.lsp.lspsaga").setup()
end

function config.nvim_cmp()
  local cmp = require("cmp")

  local sources = {
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 5 },
    { name = "luasnip" },
    { name = "path", keyword_length = 5 },
  }

  local ft = vim.o.ft
  if ft == "norg" then
    table.insert(sources, { name = "neorg" })
  end
  if ft == "markdown" then
    table.insert(sources, { name = "spell" })
  end
  if ft == "lua" then
    table.insert(sources, { name = "nvim_lua" })
  end

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-e>"] = cmp.config.disable,
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    preselect = cmp.PreselectMode.Item,
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        local kind_icons = require("core.helper").get_icons().kind_icons
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
        vim_item.menu = ({
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          neorg = "[Neorg]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          spell = "[Spell]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = sources,
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
  require("packer").loader("nvim-autopairs")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return config

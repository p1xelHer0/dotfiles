local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  return
end

local luasnip_ok, ls = pcall(require, "luasnip")
if not luasnip_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match "%s"
      == nil
end

cmp.setup {
  sources = cmp.config.sources({
    { name = "luasnip" },
  }, {
    { name = "nvim_lsp" },
  }, {
    { name = "nvim_lua" },
  }, {
    { name = "buffer" },
  }, {
    { name = "crates" },
  }),

  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },

  -- formatting = {
  --   format = function(entry, vim_item)
  --     vim_item.kind = string.format("%s", vim_item.kind)
  --     vim_item.menu = ({
  --       buffer = "[B]",
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[Snip]",
  --       nvim_lua = "[Lua]",
  --       latex_symbols = "[LaTeX]",
  --     })[entry.source.name]
  --
  --     return vim_item
  --   end,
  -- },

  mapping = {
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
      elseif ls.expandable() then
        ls.expand()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if ls.choice_active() then
        ls.change_choice(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
  },

  experimental = {
    -- native_menu = false,
    -- ghost_text = true,
  },
}

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

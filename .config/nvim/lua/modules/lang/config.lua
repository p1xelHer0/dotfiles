local config = {}

function config.refactor()
  require("refactoring").setup({})
end

function config.syntax_folding()
  local fname = vim.fn.expand("%:p:f")
  local fsize = vim.fn.getfsize(fname)
  if fsize > 1024 * 1024 then
    print("disable syntax_folding")
    vim.api.nvim_command("setlocal foldmethod=indent")
    return
  end
  vim.api.nvim_command("setlocal foldmethod=expr")
  vim.api.nvim_command("setlocal foldexpr=nvim_treesitter#foldexpr()")
end

function config.surfer()
  -- Syntax Tree Surfer
  local opts = { noremap = true, silent = true }

  -- Normal Mode Swapping:
  -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
  vim.keymap.set("n", "vU", function()
    vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
    return "g@l"
  end, { silent = true, expr = true })
  vim.keymap.set("n", "vD", function()
    vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
    return "g@l"
  end, { silent = true, expr = true })

  -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
  vim.keymap.set("n", "vd", function()
    vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
    return "g@l"
  end, { silent = true, expr = true })
  vim.keymap.set("n", "vu", function()
    vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
    return "g@l"
  end, { silent = true, expr = true })

  --> If the mappings above don't work, use these instead (no dot repeatable)
  -- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
  -- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
  -- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
  -- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)

  -- Visual Selection from Normal Mode
  vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
  vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)

  -- Select Nodes in Visual Mode
  vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
  vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
  vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
  vim.keymap.set("x", "L", "<cmd>STSSelectFirstChildNode<cr>", opts)

  -- Swapping Nodes in Visual Mode
  vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
  vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)
  require("syntax-tree-surfer").setup({})
end

function config.playground()
  require("nvim-treesitter.configs").setup({
    playground = {
      enable = true,
      disable = {},
      updatetime = 50, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = true, -- Whether the query persists across vim sessions
    },
  })
end

function config.nvim_luadev()
  vim.cmd([[vmap <leader><leader>r <Plug>(Luadev-Run)]])
end

function config.neodev() end

function config.dap() end

function config.markdown() end

return config

local loader = require("packer").loader

lprint("lazy")

local start = vim.loop.now()
local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
if fsize == nil or fsize < 0 then
  fsize = 1
end

local load_ts_plugins = true
local load_lsp = true

if fsize > 1024 * 1024 then
  load_ts_plugins = false
  load_lsp = false
end

loader("auto-dark-mode.nvim")

if vim.wo.diff then
  lprint("diffmode")
  if load_ts_plugins then
    vim.cmd([[packadd nvim-treesitter]])
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true, use_languagetree = false },
    })
  else
    vim.cmd([[syntax on]])
  end
  return
end

vim.cmd([[packadd nvim-treesitter]])
function Lazyload()
  lprint("I am lazy")
  local disable_ft = {
    "NvimTree",
    "packer",
    "TelescopePrompt",
    "csv",
    "txt",
  }

  local syn_on = not vim.tbl_contains(disable_ft, vim.bo.filetype)
  if not syn_on then
    vim.cmd([[syntax manual]])
  end

  if fsize > 6 * 1024 * 1024 then
    lprint("syntax off")
    load_lsp = false
    load_ts_plugins = false
    vim.cmd([[syntax off]])
  end

  if load_ts_plugins then
    loader("nvim-treesitter")
  end

  loader("plenary.nvim")

  if vim.bo.filetype == "lua" then
    loader("neodev.nvim")
  end

  if load_lsp then
    loader("nvim-lspconfig")
    -- loader("lspsaga.nvim")
  end

  if load_ts_plugins then
    lprint("load_ts_plugins start")
    local ts_plugins = "nvim-treesitter-textobjects nvim-ts-autotag nvim-ts-context-commentstring"
    -- nvim-treesitter-textsubjects
    loader(ts_plugins)
    loader("refactoring.nvim")
    -- loader("indent-blankline.nvim")
    loader("hlargs.nvim")
    lprint("load_ts_plugins end")
  end

  vim.cmd(
    [[autocmd FileType * silent! lua if vim.fn.wordcount()['bytes'] > 2048000 then print("Syntax off") vim.cmd("setlocal syntax=off") end]]
  )

  loader("null-ls.nvim")

  lprint("lazy colorscheme loaded", vim.loop.now() - start)
end

local lazy_timer = 20
if _G.packer_plugins == nil or _G.packer_plugins["packer.nvim"] == nil then
  vim.cmd([[PackerCompile]])
  vim.defer_fn(function()
    print("Packer recompiled, please run `:PackerCompile` and restart nvim")
  end, 400)
  return
end

vim.defer_fn(function()
  Lazyload()
end, lazy_timer)

vim.defer_fn(function()
  -- loader("galaxyline.nvim")
  -- require("modules.ui.statusline")

  -- loader("windline.nvim")
  -- require("modules.ui.eviline") -- loads winbar
  -- require("modules.ui.winbar")

  lprint("lazy wlfloat loaded", vim.loop.now() - start)
end, lazy_timer + 30)

vim.defer_fn(function()
  loader("vim-tmux-navigator")
  loader("telescope.nvim")
  loader("harpoon")

  local gitrepo = vim.fn.isdirectory(".git/index")
  if gitrepo then
    loader("gitsigns.nvim")
  end
  lprint("lazy2 loaded", vim.loop.now() - start)
end, lazy_timer + 80)

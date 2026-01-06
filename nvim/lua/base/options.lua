local options = require("base.config").get_options()

-- stylua: ignore start
vim.g.mapleader       = " "
vim.g.maplocalleader  = ","

vim.o.clipboard       = "unnamedplus"
vim.o.grepformat      = "%f:%l:%c:%m"
vim.o.grepprg         = "rg --vimgrep"
vim.o.shada           = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
vim.o.switchbuf       = "usetab"       -- Use already opened buffers when switching
vim.o.undofile        = true           -- Enable persistent undo
vim.o.updatetime      = 250

vim.o.scrolloff       = options.scrolloff
vim.o.sidescrolloff   = options.scrolloff

-- UI
vim.o.breakindent     = true
vim.o.breakindentopt  = "list:-1"
vim.o.conceallevel    = 2
vim.o.cursorline      = true
vim.o.cursorlineopt   = "screenline,number" -- Show cursor line per screen line
vim.o.list            = true
vim.o.number          = true
vim.o.pumblend        = options.blend
vim.o.pumheight       = 15
vim.o.relativenumber  = true
vim.o.shortmess       = "aoIcFW"
vim.o.showmode        = false
vim.o.signcolumn      = "yes"
vim.o.splitbelow      = true
vim.o.splitkeep       = "screen"
vim.o.splitright      = true
vim.o.winblend        = options.blend
vim.o.winborder       = "solid"
vim.o.wrap            = false
vim.opt.fillchars = {
  stl                 = " ",
  stlnc               = " ",
  wbr                 = " ",
  horiz               = "━",
  horizup             = "┻",
  horizdown           = "┳",
  vert                = "┃",
  vertleft            = "┫",
  vertright           = "┣",
  verthoriz           = "╋",
  fold                = "─",
  foldopen            = "",
  foldclose           = "",
  foldsep             = "│",
  diff                = "░",
  msgsep              = " ",
  eob                 = "~",
  lastline            = "@",
}
vim.opt.listchars = {
  eol                 = " " ,
  tab                 = "> ",
  trail               = "·" ,
  extends             = "…" ,
  precedes            = "…" ,
  nbsp                = "␣" ,
}

-- Fold
vim.o.foldlevel       = 10
vim.o.foldmethod      = "indent"
vim.o.foldnestmax     = 10
vim.o.foldtext        = ""

-- Editing
vim.o.autoindent      = true
vim.o.expandtab       = true
vim.o.formatoptions   = "rqnl1j"-- Improve comment editing
vim.o.ignorecase      = true    -- Ignore case during search
vim.o.incsearch       = true    -- Show search matches while typing
vim.o.infercase       = true    -- Infer case in built-in completion
vim.o.shiftwidth      = 2
vim.o.smartcase       = true    -- Respect case if search pattern has upper case
vim.o.smartindent     = true
vim.o.spelloptions    = 'camel' -- Treat camelCase word parts as separate words
vim.o.tabstop         = 2
vim.o.virtualedit     = 'block' -- Allow going past end of line in blockwise mode
vim.o.iskeyword       = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
vim.o.formatlistpat   = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Completion
vim.o.complete        = ".,w,b,kspell"                  -- Use less sources
vim.o.completeopt     = "menuone,noselect,fuzzy,nosort" -- Use custom behavior
vim.o.wildoptions     = "pum" -- Display the completion matches using the popup menu in the same style as the ins-completion-menu.

vim.o.wildignorecase  = true
-- stylua: ignore end

-- Perf
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

-- /////////////////////////////////

local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { noremap = true, desc = "Base: " .. desc })
end

-- stylua: ignore start
map(" ", "", "unbind leader conflict [n]")
map(",", "", "unbind localleader conflicts [n]")
map(" ", "", "unbind leader conflict [x]", "x")
map(",", "", "unbind localleader conflicts [x]", "x")

map("<Leader>w", ":w<CR>",  "[w]rite")
map("<Leader>W", ":w!<CR>", "[w]rite!")
map("<Leader>q", ":q<CR>",  "[q]uit")
map("<Leader>Q", ":q!<CR>", "[q]it!")
map("<Leader>x", ":x<CR>",  "e[x]it")
map("<Leader>X", ":x!<CR>", "e[x]it!")
map("<Leader>e", ":e<CR>",  "[e]dit")

map("<Leader>/", "<Cmd>noh<CR>", "clear highlights")
-- stylua: ignore end

-- //////////////////////

local base_options_group = vim.api.nvim_create_augroup("base.options", {})
local autocmd = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, {
    group = base_options_group,
    pattern = pattern,
    callback = callback,
    desc = "Base: " .. desc,
  })
end

autocmd("FileType", "qf", function() vim.opt_local.buflisted = false end, "don't list quickfix buffers in buffer list")

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
-- Do on `FileType` to always override these changes from filetype plugins
autocmd("FileType", nil, function()
  vim.opt_local.formatoptions:remove("c")
  vim.opt_local.formatoptions:remove("o")
end, "fix 'o' with comments")

autocmd("TextYankPost", "*", function() vim.hl.on_yank({ higroup = "Search", timeout = 400 }) end, "highlight on yank")

-- Hide cursorline in Insert mode
if vim.opt_local.cursorline:get() then
  autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, "*", function()
    if vim.opt_local.cursorline:get() then vim.opt_local.cursorline = false end
  end, "hide cursorline when leaving buffer")

  autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, "*", function()
    if not vim.opt_local.cursorline:get() then vim.opt_local.cursorline = true end
  end, "show cursorline when entering buffer")
end

-- autocmd("BufWritePost", "theme.lua", function() vim.cmd("Lazy reload mibo") end, "reload theme on save")

-- ///////////////////////////

vim.diagnostic.config({
  signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },
  severity_sort = true,
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
  },
  jump = {
    float = {
      source = "if_many",
      focusable = false,
    },
  },
  update_in_insert = false,
})

-- TODO: move

vim.filetype.add({
  extension = {
    hlsl = "hlsl",
    hlsli = "hlsl",
  },
})

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf].filetype ~= "bigfile" and path and vim.fn.getfsize(path) > options.bigfile_size and "bigfile"
          or nil
      end,
    },
  },
})

autocmd("FileType", "bigfile", function(event)
  vim.schedule(function() vim.bo[event.buf].syntax = vim.filetype.match({ buf = event.buf }) or "" end)
end, "bigfile")

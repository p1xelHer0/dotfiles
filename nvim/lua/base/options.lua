vim.g.mapleader = " "
vim.g.maplocalleader = ","

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

local options = require("base.config").get_options()

-- stylua: ignore start
vim.opt.termguicolors   = true
vim.opt.syntax          = "off"

vim.opt.shortmess       = "aoIcFW"

vim.opt.expandtab       = true
vim.opt.shiftwidth      = 2
vim.opt.smartindent     = true
vim.opt.tabstop         = 2
vim.opt.softtabstop     = 0

vim.opt.foldmethod      = "expr"
vim.opt.foldexpr        = "nvim_treesitter#foldexpr()"
vim.opt.foldenable      = false

vim.opt.fillchars = {
  stl             = " ",
  stlnc           = " ",
  wbr             = " ",
  horiz           = " ",
  horizup         = " ",
  horizdown       = " ",
  vert            = " ",
  vertleft        = " ",
  vertright       = " ",
  verthoriz       = " ",
  fold            = "·",
  foldopen        = "-",
  foldclose       = "+",
  foldsep         = " ",
  diff            = "-",
  msgsep          = " ",
  eob             = "~",
}
vim.opt.list            = true
vim.opt.listchars = {
  eol             = " " ,
  tab             = "⇥ ",
  trail           = "·" ,
  extends         = "→" ,
  precedes        = "←" ,
  nbsp            = "␣" ,
}
vim.opt.wrap            = true
vim.opt.showbreak       = "↪ "
vim.opt.conceallevel    = 2

vim.opt.ttimeoutlen     = 10
vim.opt.timeoutlen      = 300
vim.opt.updatetime      = 250
vim.opt.redrawtime      = 100

vim.opt.fileformats     = "unix"
vim.opt.encoding        = "utf-8"
vim.opt.fileencoding    = "utf-8"

vim.opt.grepprg         = 'rg --hidden --vimgrep --smart-case'
vim.opt.grepformat      = "%f:%l:%c:%m"

vim.opt.clipboard       = "unnamedplus"

vim.opt.undofile        = true
vim.opt.exrc            = false
vim.opt.errorbells      = false

vim.opt.ignorecase      = true
vim.opt.smartcase       = true
vim.opt.completeopt     = "menu,menuone,noselect"
vim.opt.infercase       = true
vim.opt.wildoptions     = "pum"
vim.opt.pumheight       = 15
vim.opt.pumblend        = options.blend
vim.opt.wildignorecase  = true

vim.opt.showmode        = false
vim.opt.scrolloff       = options.scrolloff
vim.opt.sidescrolloff   = options.scrolloff
vim.opt.breakindentopt  = "shift:2,min:20"
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.signcolumn      = "yes"
vim.opt.cursorline      = true

vim.opt.winwidth        = 30
vim.opt.winminwidth     = 10
vim.opt.winblend        = options.blend
vim.opt.winborder       = "single"
vim.opt.helpheight      = 12
vim.opt.previewheight   = 12
vim.opt.splitbelow      = true
vim.opt.splitright      = true
-- stylua: ignore end

-- perf
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

map("<Leader>0", ":Inspect<CR>", "tree-sitter - inspect")

local base_options_group = vim.api.nvim_create_augroup("base.options", {})

-- Don't list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
  group = base_options_group,
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = base_options_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
})

-- Hide cursorline in Insert mode
if vim.opt_local.cursorline:get() then
  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = base_options_group,
    pattern = "*",
    callback = function()
      if vim.opt_local.cursorline:get() then
        vim.opt_local.cursorline = false
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = base_options_group,
    pattern = "*",
    callback = function()
      if not vim.opt_local.cursorline:get() then
        vim.opt_local.cursorline = true
      end
    end,
  })
end

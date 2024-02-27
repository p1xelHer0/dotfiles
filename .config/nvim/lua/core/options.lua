local o = vim.opt
local blend = 7

local scrolloff = require("core.config").get_options().scrolloff

-- stylua: ignore start
o.termguicolors   = true
o.syntax          = "off"

o.shortmess       = "aoIcFW"

o.fillchars = {
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
o.list            = true
o.listchars = {
  eol             = " " ,
  tab             = "» ",
  trail           = "·" ,
  extends         = "→" ,
  precedes        = "←" ,
  nbsp            = "␣" ,
}
o.showbreak       = "↪ "
o.conceallevel    = 2

o.ttimeoutlen     = 10
o.timeoutlen      = 300
o.updatetime      = 250
o.redrawtime      = 100

o.fileformats     = "unix"
o.encoding        = "utf-8"
o.fileencoding    = "utf-8"

o.grepprg         = 'rg --hidden --vimgrep --smart-case'
o.grepformat      = "%f:%l:%c:%m"

o.clipboard       = "unnamedplus"

o.undofile        = true
o.exrc            = false
o.errorbells      = false

o.spelllang       = "en_us"
o.spellfile       = require("core.config").get_dotfiles_path() .. "/.config/nvim/spell/en.uft-8.add"

o.ignorecase      = true
o.smartcase       = true
o.completeopt     = "menu,menuone,noselect"
o.infercase       = true
o.wildoptions     = "pum"
o.pumheight       = 15
o.pumblend        = blend
o.wildignorecase  = true

o.showmode        = false
o.scrolloff       = scrolloff
o.sidescrolloff   = scrolloff
o.breakindentopt  = "shift:2,min:20"
o.number          = false
o.relativenumber  = false
o.signcolumn      = "no"
o.cursorline      = false

o.winwidth        = 30
o.winminwidth     = 10
o.winblend        = blend
o.helpheight      = 12
o.previewheight   = 12
o.splitbelow      = true
o.splitright      = true
-- stylua: ignore end

local o = vim.opt
local blend = 7

-- stylua: ignore start
o.mouse           = ''
o.exrc            = false
o.modelines       = 1
o.errorbells      = false
o.termguicolors   = true
o.syntax          = 'off'
o.background      = 'dark'
o.synmaxcol       = 1000
o.shortmess       = 'aoIcF'
o.fillchars = {
  stl             = ' ',
  stlnc           = ' ',
  wbr             = ' ',
  horiz           = '─',
  horizup         = '┴',
  horizdown       = '┬',
  vert            = '│',
  vertleft        = '┤',
  vertright       = '├',
  verthoriz       = '┼',
  fold            = '·',
  foldopen        = '-',
  foldclose       = '+',
  foldsep         = '│',
  diff            = '-',
  msgsep          = ' ',
  eob             = '~',
}
o.ttimeoutlen     = 10
o.ttimeout        = true
o.timeoutlen      = 500
o.timeout         = true
o.updatetime      = 250
o.redrawtime      = 100

o.fileformats     = 'unix'
o.encoding        = 'utf-8'
o.fileencoding    = 'utf-8'

o.path            = [[.,,,$PWD/**]]
o.grepprg         = 'rg --hidden --vimgrep --smart-case --glob "!{.git,node_modules,*~}/*" --'
o.grepformat      = "%f:%l:%c:%m"

o.clipboard       = 'unnamedplus'

o.autochdir       = false
o.hidden          = true
o.undofile        = true
o.swapfile        = false
o.backup          = false
o.writebackup     = false
o.backupskip      = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*'
o.spellfile       = require("core.config").get_dotfiles_path() .. '/.config/nvim/spell/en.uft-8.add'
o.history         = 4000
o.shada           = [[!,'100,<0,s100,h]]
o.sessionoptions  = 'blank,buffers,curdir,folds,help,tabpages,winsize'

o.magic           = true
o.hlsearch        = true
o.incsearch       = true
o.ignorecase      = true
o.smartcase       = true
o.showmatch       = false
o.inccommand      = 'nosplit'
o.wrapscan        = true

o.tabstop         = 2
o.softtabstop     = 2
o.shiftwidth      = 2
o.shiftround      = true
o.expandtab       = true
o.smarttab        = true

o.diffopt         = 'filler,internal,algorithm:patience'
o.jumpoptions     = 'stack'

o.formatoptions   = o.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

o.completeopt     = 'menu,menuone,noselect'
o.infercase       = true
o.wildmenu        = true
o.wildoptions     = 'pum'
o.pumheight       = 15
o.pumblend        = blend
o.wildignorecase  = true
o.wildignore      = '.git/**,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**'

o.autoindent      = true
o.smartindent     = true
o.startofline     = false

o.showmode        = true
o.showcmd         = true
o.laststatus      = 3
o.scrolloff       = 5
o.sidescrolloff   = 5
o.textwidth       = 80
o.wrap            = true
o.linebreak       = true
o.breakindentopt  = 'shift:2,min:20'
o.ruler           = true
o.number          = true
o.relativenumber  = true
o.signcolumn      = 'yes'
o.list            = true
o.listchars = {
  eol             = " " ,
  tab             = '» ',
  trail           = '·' ,
  extends         = '→' ,
  precedes        = '←' ,
  nbsp            = '␣' ,
}
o.showbreak       = '↪ '

o.foldenable      = true
o.foldlevel       = 99
o.foldlevelstart  = 99
o.foldmethod      = 'indent'

o.winwidth        = 30
o.winminwidth     = 10
o.winblend        = blend
o.helpheight      = 12
o.previewheight   = 12
o.splitbelow      = true
o.splitright      = true
-- stylua: ignore end

local config = require("core.config")
local signs = config.get_icons()

local diagnostic_signs = signs.diagnostic
for type, icon in pairs(diagnostic_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
local severity_signs = signs.severity

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = {
    source = "if_many",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s %s ", severity_signs[diagnostic.severity], diagnostic.message)
    end,
  },
  update_in_insert = false,
  severity_sort = true,
})

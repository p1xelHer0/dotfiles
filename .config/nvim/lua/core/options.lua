local global = require 'core.global'

local o = vim.opt

-- stylua: ignore start
o.mouse         = ''
o.exrc          = false
o.modelines     = 1
o.errorbells    = false
o.termguicolors = true
o.syntax        = 'off' -- set by Tree-sitter - modules/lang/treesitter.lua
o.background    = 'dark' -- set by auto-dark-mode.nvim - modules/ui/config.lua
o.synmaxcol     = 1000
o.shortmess     = 'aoIcF'

o.updatetime  = 250
o.timeout     = true
o.ttimeout    = true
o.timeoutlen  = 500
o.ttimeoutlen = 10
o.redrawtime  = 100

o.fileformats  = 'unix'
o.encoding     = 'utf-8'
o.fileencoding = 'utf-8'

o.path = [[.,,,$PWD/**]]

o.clipboard = 'unnamedplus'

o.autochdir      = false
o.hidden         = true
o.undofile       = true
o.swapfile       = false
o.backup         = false
o.writebackup    = false
o.backupskip     = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim'
o.directory      = global.cache_dir .. 'swap/'
o.undodir        = global.cache_dir .. 'undo/'
o.backupdir      = global.cache_dir .. 'backup/'
o.viewdir        = global.cache_dir .. 'view/'
o.spellfile      = global.cache_dir .. 'spell/en.uft-8.add'
o.history        = 4000
o.shada          = [[!,'100,<0,s100,h]]
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize'

o.magic      = true
o.hlsearch   = true
o.incsearch  = true
o.ignorecase = true
o.smartcase  = true
o.showmatch  = false
o.inccommand = 'nosplit'
o.wrapscan   = true

o.tabstop     = 2
o.softtabstop = 2
o.shiftwidth  = 2
o.shiftround  = true
o.expandtab   = true
o.smarttab    = true

o.diffopt     = 'filler,internal,algorithm:patience'
o.jumpoptions = 'stack'

o.formatoptions = o.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

-- o.completeopt     = 'menuone,noselect'
o.infercase      = true
o.wildmenu       = true
o.wildoptions    = 'pum'
o.pumheight      = 15
o.pumblend       = 20
o.wildignorecase = true
o.wildignore     = '.git/**,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**'

o.autoindent  = true
o.smartindent = true
o.startofline = false

o.showmode       = true
o.showcmd        = true
o.laststatus     = 3
o.scrolloff      = 5
o.sidescrolloff  = 5
o.textwidth      = 80
o.wrap           = true
o.linebreak      = true
o.breakindentopt = 'shift:2,min:20'
o.ruler          = true
o.number         = true
o.signcolumn     = 'yes'
o.conceallevel   = 2
o.concealcursor  = 'niv'
o.list           = true
o.listchars      = {
  tab      = '» ',
  nbsp     = '␣',
  trail    = '·',
  extends  = '→',
  precedes = '←',
}
o.showbreak      = '↪ '

o.foldenable     = true
o.foldlevel      = 99
o.foldlevelstart = 99
o.foldmethod     = 'indent'

o.winwidth      = 30
o.winminwidth   = 10
o.winblend      = 20
o.helpheight    = 12
o.previewheight = 12
o.splitbelow    = true
o.splitright    = true
-- stylua: ignore end

if global.is_mac then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
end

if vim.fn.executable 'rg' == 1 then
  o.grepprg = 'rg --hidden --vimgrep --smart-case --glob "!{.git,node_modules,*~}/*" --'
  o.grepformat = '%f:%l:%c:%m'
end

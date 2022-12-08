local editor = {}
local conf = require 'modules.editor.config'

editor['chaoren/vim-wordmotion'] = {
  keys = { '<Plug>WordMotion_w', '<Plug>WordMotion_b' },
  -- opt = true,
}

editor['phaazon/hop.nvim'] = {
  as = 'hop',
  cmd = {
    'HopWord',
    'HopWordMW',
    'HopWordAC',
    'HopWordBC',
    'HopLine',
    'HopChar1',
    'HopChar1MW',
    'HopChar1AC',
    'HopChar1BC',
    'HopChar2',
    'HopChar2MW',
    'HopChar2AC',
    'HopChar2BC',
    'HopPattern',
    'HopPatternAC',
    'HopPatternBC',
    'HopChar1CurrentLineAC',
    'HopChar1CurrentLineBC',
    'HopChar1CurrentLine',
  },
  config = function()
    require('hop').setup { keys = 'adghklqwertyuiopzxcvbnmfjADHKLWERTYUIOPZXCVBNMFJ1234567890' }
  end,
}

editor['indianboy42/hop-extensions'] = {
  after = 'hop',
  opt = true
}

editor['windwp/nvim-autopairs'] = {
  after = { 'nvim-cmp' },
  config = conf.autopairs,
  opt = true,
}

editor['andymass/vim-matchup'] = {
  cmd = {
    'MatchupWhereAmI?',
    'MatchupWhereAmI??',
    'MatchupShowTimes',
    'MatchupClearTimes',
    'MatchupReload',
  },
  config = function()
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    vim.cmd [[nnoremap <c-s-k> :<c-u>MatchupWhereAmI?<cr>]]
  end,
  event = { 'CursorHold', 'CursorHoldI' },
  opt = true,
}

editor['nvim-neorg/neorg'] = {
  config = conf.neorg,
  ft = 'norg',
  opt = true,
  requires = { 'nvim-neorg/neorg-telescope', ft = { 'norg' } },
}

editor['AndrewRadev/switch.vim'] = {
  cmd = { 'Switch', 'Switch!', 'Switch?', 'SwitchCase', 'SwitchCase!' },
  keys = { '<Plug>(Switch)' },
  opt = true,
}

editor['tpope/vim-abolish'] = {
  event = { 'CmdlineEnter' },
  keys = { '<Plug>(abolish-coerce-word)' },
  opt = true,
}

editor['numToStr/Comment.nvim'] = {
  keys = { 'g', '<ESC>', 'v', 'V', '<c-v>' },
  config = conf.comment,
}

editor['norcalli/nvim-colorizer.lua'] = {
  opt = true,
}

return editor

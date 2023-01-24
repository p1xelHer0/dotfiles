local editor = {}
local conf = require("modules.editor.config")

editor["windwp/nvim-autopairs"] = {
  after = { "nvim-cmp" },
  config = conf.autopairs,
  opt = true,
}

editor["andymass/vim-matchup"] = {
  cmd = {
    "MatchupWhereAmI?",
    "MatchupWhereAmI??",
    "MatchupShowTimes",
    "MatchupClearTimes",
    "MatchupReload",
  },
  config = function()
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    vim.cmd([[nnoremap <c-s-k> :<c-u>MatchupWhereAmI?<cr>]])
  end,
  event = { "CursorHold", "CursorHoldI" },
  opt = true,
}

editor["nvim-neorg/neorg"] = {
  config = conf.neorg,
  ft = "norg",
  opt = true,
  requires = { "nvim-neorg/neorg-telescope", ft = { "norg" } },
}

editor["AndrewRadev/switch.vim"] = {
  cmd = { "Switch", "Switch!", "Switch?", "SwitchCase", "SwitchCase!" },
  keys = { "<Plug>(Switch)" },
  opt = true,
}

editor["tpope/vim-abolish"] = {
  event = { "CmdlineEnter" },
  keys = { "<Plug>(abolish-coerce-word)" },
  opt = true,
}

editor["numToStr/Comment.nvim"] = {
  keys = { "g", "<ESC>", "v", "V", "<c-v>" },
  config = conf.comment,
}

editor["NvChad/nvim-colorizer.lua"] = {
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
  opt = true,
}

return editor

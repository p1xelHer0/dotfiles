local ui = {}
local conf = require 'modules.ui.config'

ui['kyazdani42/nvim-web-devicons'] = {}

ui['f-person/auto-dark-mode.nvim'] = {
  config = conf.auto_dark_mode,
  opt = true,
  requires = { 'folke/tokyonight.nvim' },
}

ui['windwp/windline.nvim'] = {
  config = conf.windline,
  opt = true,
}

ui['rcarriga/nvim-notify'] = {
  opt = true,
  config = conf.notify,
}

ui['folke/noice.nvim'] = {
  opt = true,
  module = 'noice',
  config = conf.noice,
}

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  config = conf.nvim_tree,
  opt = true,
  setup = conf.nvim_tree_setup,
}

ui["lukas-reineke/indent-blankline.nvim"] = {
  config = conf.blankline,
  opt = true,
}

ui['dstein64/nvim-scrollview'] = {
  config = conf.scrollview,
  event = { 'CursorMoved', 'CursorMovedI' },
}

ui['folke/tokyonight.nvim'] = {
  opt = true,
  setup = conf.tokyonight,
}

ui['gelguy/wilder.nvim'] = {
  config = conf.wilder,
  event = { 'CmdwinEnter', 'CmdlineEnter' },
  opt = true,
  requires = {
    { 'romgrk/fzy-lua-native' },
  },
  run = function()
    vim.cmd [[packadd wilder.nvim]]
    vim.cmd [[silent UpdateRemotePlugins]]
  end,
}

return ui

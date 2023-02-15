local g = vim.g
local helper = require("core.helper")

local createdir = function()
  local cache_dir = helper.get_cache_path()
  local data_dir = {
    cache_dir .. "/backup",
    cache_dir .. "/session",
    cache_dir .. "/swap",
    cache_dir .. "/tags",
    cache_dir .. "/undo",
  }

  if vim.fn.isdirectory(cache_dir) == 0 then
    os.execute("mkdir -p " .. cache_dir)
    for _, v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

createdir()

g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

g.loaded_node_provider = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

g.mapleader = " "
vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
vim.api.nvim_set_keymap("x", " ", "", { noremap = true })

local lazy_path = helper.get_lazy_path()
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazy_path,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazy_path)

-- local pack = require("core.pack")

local lazy_vim = require("core.lazy_vim")
lazy_vim.setup()

require("core.options")
require("keymap")
require("internal.autocmd")

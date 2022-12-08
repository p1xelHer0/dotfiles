-- https://github.com/ziontee113/luasnip-tutorial/
local ls = require("luasnip")

require("luasnip.loaders.from_lua").load({
  paths = { "~/dotfiles/.config/nvim/lua/snippets/" },
})

require("luasnip.loaders.from_vscode").load({})

local types = require("luasnip.util.types")
ls.config.set_config({ --{{{
  history = false,
  updateevents = "TextChanged,TextChangedI",
})

vim.schedule(function()
  require("luasnip.loaders.from_vscode").load()
end)

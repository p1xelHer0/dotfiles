local lsp = {}
local conf = require("modules.lsp.config")

lsp["neovim/nvim-lspconfig"] = {
  config = conf.nvim_lspconfig,
  opt = true,
}

lsp["jose-elias-alvarez/null-ls.nvim"] = {
  config = require("modules.lsp.null-ls").config,
  opt = true,
}

lsp["glepnir/lspsaga.nvim"] = {
  branch = "main",
  config = conf.lspsaga,
  opt = true,
}

lsp["hrsh7th/nvim-cmp"] = {
  after = { "LuaSnip" },
  config = conf.nvim_cmp,
  requires = {
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-path", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = true },
    { "f3fora/cmp-spell", after = "nvim-cmp", opt = true },
    { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
  },
}

lsp["L3MON4D3/LuaSnip"] = {
  config = function()
    require("modules.lsp.luasnip")
  end,
  event = "InsertEnter",
}

return lsp

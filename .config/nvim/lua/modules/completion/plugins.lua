local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
  config = conf.nvim_lsp,
  opt = true,
}

completion["hrsh7th/nvim-cmp"] = {
  after = { "LuaSnip" },
  config = conf.nvim_cmp,
  requires = {
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-path", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-calc", after = "nvim-cmp", opt = true },
    { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
  },
}

completion["L3MON4D3/LuaSnip"] = {
  config = function() require('modules.completion.luasnip') end,
  event = "InsertEnter",
}

completion["kristijanhusak/vim-dadbod-completion"] = {
  event = "InsertEnter",
  ft = { "sql" },
  setup = function()
    vim.cmd([[autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni]])
  end,
}

completion["nvim-telescope/telescope.nvim"] = {
  config = conf.telescope,
  setup = conf.telescope_preload,
  requires = {
    { "nvim-lua/plenary.nvim", opt = true },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
    { "nvim-telescope/telescope-live-grep-args.nvim", opt = true },
    { "nvim-telescope/telescope-file-browser.nvim", opt = true },
  },
  opt = true,
}

completion["mattn/emmet-vim"] = {
  event = "InsertEnter",
  ft = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "vue",
    "typescript",
    "typescriptreact",
    "scss",
    "sass",
    "less",
    "jade",
    "haml",
    "elm",
  },
  setup = conf.emmet,
}
return completion

local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  context_commentstring = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

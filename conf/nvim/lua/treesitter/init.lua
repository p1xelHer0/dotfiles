local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  context_commentstring = { enable = true },
  highlight = {
    enable = false,
    use_languagetree = false,
  },
  indent = { enable = false },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  playground = {
    enable = true,
  },
}

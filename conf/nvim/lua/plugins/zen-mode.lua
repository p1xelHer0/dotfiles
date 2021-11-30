local zen_mode = require "zen-mode"

zen_mode.setup {
  options = {
    signcolumn = "no",
    number = false,
    relativenumber = false,
    cursorline = false,
    cursorcolumn = false,
    foldcolumn = "0",
    list = false,
  },
  plugins = {
    tmux = {
      enabled = true,
    },
    gitsigns = {
      enabled = false,
    },
  },
}

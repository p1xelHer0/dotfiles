local zen_mode = require "zen-mode"

zen_mode.setup {
  plugins = {
    tmux = {
      enabled = true,
    },
    gitsigns = {
      enabled = false,
    },
  },
}

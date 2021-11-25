local telescope = require "telescope"

telescope.setup {
  defaults = {
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    mappings = {
      n = {
        ["<C-c>"] = require("telescope.actions").close,
      },
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "frecency"
telescope.load_extension "octo"

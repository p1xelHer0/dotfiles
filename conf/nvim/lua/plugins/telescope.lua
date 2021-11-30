local telescope = require "telescope"

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    mappings = {
      n = {
        ["<C-c>"] = actions.close,
      },
      i = {
        ["<C-u>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "frecency"
telescope.load_extension "octo"

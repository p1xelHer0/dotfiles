local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

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
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      find_command = {
        hidden = true,
      },
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "frecency"

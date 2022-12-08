local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

vim.keymap.set(
  "n",
  "<C-p>",
  builtin.find_files,
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<Leader>f",
  builtin.live_grep,
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<Leader>b",
  builtin.buffers,
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<Leader>p",
  telescope.extensions.frecency.frecency,
  { noremap = true, silent = true }
)

telescope.setup {
  defaults = {
    -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
      additional_args = function()
        return { "--hidden" }
      end,
    },
  },
  ["ui-select"] = {
    require("telescope.themes").get_dropdown {},
  },
}

telescope.load_extension "ui-select"
telescope.load_extension "frecency"

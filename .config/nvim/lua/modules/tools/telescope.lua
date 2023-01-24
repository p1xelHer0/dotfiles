local loader = require("packer").loader
if not packer_plugins["telescope.nvim"].loaded then
  loader("telescope.nvim")
end
local telescope = require("telescope")
local actions = require("telescope.actions")

local M = {}

M.setup = function(_)
  telescope.setup({
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
        -- theme = "dropdown",
      },
      live_grep = {
        -- theme = "dropdown",
        additional_args = function()
          return { "--hidden" }
        end,
      },
    },
  })

  vim.defer_fn(function() -- defer loading
    loader("telescope-live-grep-args.nvim telescope-file-browser.nvim")
    loader("project.nvim telescope-zoxide")
    loader("sqlite.lua")
    loader("telescope-fzf-native.nvim")
    loader("telescope-frecency.nvim nvim-neoclip.lua")

    telescope.load_extension("fzf")
    telescope.load_extension("dotfiles")
    telescope.load_extension("gosource")
  end, 200)
end

return M

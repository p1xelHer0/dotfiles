local M = {
  "nvim-tree/nvim-tree.lua",
  keys = {
    {
      mode = "n",
      "<Leader>n",
      "<Cmd>NvimTreeToggle<CR>",
      { noremap = true, silent = true },
    },
    {
      mode = "n",
      "<Leader>N",
      "<Cmd>NvimTreeFindFile<CR>",
      { noremap = true, silent = true },
    },
  },
  cmd = {
    "NvimTreeOpen",
    "NvimTreeClose",
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeRefresh",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
    "NvimTreeClipboard",
    "NvimTreeResize",
    "NvimTreeCollapse",
    "NvimTreeCollapseKeepBuffers",
    "NvimTreeGenerateOnAttach",
  },
  opts = {
    git = { ignore = false },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "/",
            open = "—",
            empty = "\\",
            empty_open = "-",
            symlink = ">",
            symlink_open = "v",
          },
          git = {
            deleted = require("core.config").get_icons().git.deleted,
            renamed = require("core.config").get_icons().git.renamed,
            staged = require("core.config").get_icons().git.staged,
            unmerged = require("core.config").get_icons().git.unmerged,
            unstaged = require("core.config").get_icons().git.unstaged,
            untracked = require("core.config").get_icons().git.untracked,
            ignored = require("core.config").get_icons().git.ignored,
          },
        },
      },
    },
  },
}

return M

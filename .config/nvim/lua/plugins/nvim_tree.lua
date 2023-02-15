local M = {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { mode = "n", "<Leader>n", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true } },
    { mode = "n", "<Leader>N", "<Cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true } },
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
            deleted = "-",
            renamed = '"',
            staged = "^",
            unmerged = "=",
            unstaged = "~",
            untracked = "+",
            ignored = "",
          },
        },
      },
    },
  },
}

return M

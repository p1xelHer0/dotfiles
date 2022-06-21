local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
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
}

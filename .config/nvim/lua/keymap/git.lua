local M = {}

---@param client? string
---@param bufnr? string
M.setup = function(bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local gs = package.loaded.gitsigns

  k("n", "]c", gs.next_hunk, opts)
  k("n", "[c", gs.prev_hunk, opts)
  k("n", "<Leader>gs", gs.prev_hunk, opts)
end

return M

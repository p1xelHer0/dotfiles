local M = {}

---@param client? string
---@param bufnr? string
M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true }

  k("n", "<Leader>p", ":A<CR>", opts)
end

return M

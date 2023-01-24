local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local lsp = require("internal.lsp")

  k("n", "<Leader><Leader>f", lsp.format(client, bufnr), { silent = true, buffer = true })
end

return M

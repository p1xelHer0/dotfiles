local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local lsp = require("internal.lsp")

  k("n", "K", "<Cmd>RustHoverActions<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "ga", "<Cmd>RustCodeAction<CR>", { noremap = true, silent = true, buffer = true })

  k("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, buffer = true })
  k("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, buffer = true })
  k("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, buffer = true })
  k("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, buffer = true })
  k("n", "gr", vim.lsp.buf.rename, { noremap = true, silent = true, buffer = true })
end

return M

local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }

  k("n", "]d", vim.diagnostic.goto_next, opts)
  k("n", "[d", vim.diagnostic.goto_prev, opts)
  k("n", "K", vim.lsp.buf.hover, opts)
  k("n", "ga", vim.lsp.buf.code_action, opts)
  k("n", "gd", vim.lsp.buf.definition, opts)
  k("n", "gD", vim.lsp.buf.declaration, opts)
  k("n", "gr", vim.lsp.buf.rename, opts)
end

return M

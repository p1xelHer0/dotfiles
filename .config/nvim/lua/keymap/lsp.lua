local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local lsp = require("internal.lsp")

  k("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "]e", lsp.jump_to_error_next(), { noremap = true, silent = true, buffer = true })
  k("n", "[e", lsp.jump_to_error_prev(), { noremap = true, silent = true, buffer = true })
  k("n", "[c", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "K", "<Cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "ga", "<Cmd>Lspsaga code_action<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, buffer = true })
  k("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, buffer = true })
  k("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "gr", "<Cmd>Lspsaga rename<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", { noremap = true, silent = true, buffer = true })
  k("n", "<Leader>o", "<Cmd>Lspsaga outline<CR>", { noremap = true, silent = true, buffer = true })
end

return M

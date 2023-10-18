local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return capabilities
end

function M.on_attach(client, bufnr)
  require("keymap.lsp").setup(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    -- require("navic-nvim").attach(client, bufnr)
  end

  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")

  -- setup client specific keymap if it exists
  local has_keymap_file, current_client = pcall(require, "keymap." .. client.name)
  if has_keymap_file then
    current_client.setup(client, bufnr)
  end
end

return M

local M = {}

---@param client? string
---@param bufnr? string
M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local capabilities = client.server_capabilities

  -- vim.print(capabilities)

  k("n", "]d", function()
    vim.diagnostic.goto_next({
      severity = require("internal.lsp").diagnostic_severity(),
    })
  end, opts)
  k("n", "[d", function()
    vim.diagnostic.goto_prev({
      severity = require("internal.lsp").diagnostic_severity(),
    })
  end, opts)

  if capabilities.hoverProvider then
    k("n", "K", vim.lsp.buf.hover, opts)
  end

  if capabilities.typeDefinitionProvider then
    k("n", "gD", vim.lsp.buf.declaration, opts)
    k("n", "gd", vim.lsp.buf.definition, opts)
  end

  if capabilities.renameProvider then
    k("n", "gn", vim.lsp.buf.rename, opts)
  end

  if capabilities.referencesProvider then
    k("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
  end

  if capabilities.documentSymbolProvider then
    k("n", "gs", "<Cmd>Telescope lsp_document_symbols<CR>", opts)
  end

  if capabilities.workspaceSymbolProbider then
    k("n", "gS", "<Cmd>Telescope lsp_workspace_symbols<CR>", opts)
  end

  if capabilities.codeActionProvider then
    k("n", "ga", vim.lsp.buf.code_action, opts)
  end
end

return M

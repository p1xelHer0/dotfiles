local M = {}

---@param client? string
---@param bufnr? string
M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }

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
  -- @TODO - only add these capable
  k("n", "K", vim.lsp.buf.hover, opts)
  k("n", "ga", vim.lsp.buf.code_action, opts)
  k("n", "gd", vim.lsp.buf.definition, opts)
  k("n", "gD", vim.lsp.buf.declaration, opts)
  k("n", "gn", vim.lsp.buf.rename, opts)
  k("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
  k("n", "gs", "<Cmd>Telescope lsp_document_symbols<CR>", opts)
  k("n", "gS", "<Cmd>Telescope lsp_workspace_symbols<CR>", opts)
end

return M

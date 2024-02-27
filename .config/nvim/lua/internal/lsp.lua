local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return capabilities
end

---Returns the highest vim.diagnostic.severity
---@return integer | nil
function M.diagnostic_severity()
  local num_warnings = 0

  for _, d in ipairs(vim.diagnostic.get(0)) do
    if d.severity == vim.diagnostic.severity.ERROR then
      return vim.diagnostic.severity.ERROR
    elseif d.severity == vim.diagnostic.severity.WARN then
      num_warnings = num_warnings + 1
    end
  end

  if num_warnings > 0 then
    return vim.diagnostic.severity.WARN
  else
    return nil
  end
end

function M.on_attach(client, bufnr)
  require("keymap.lsp").setup(client, bufnr)

  -- vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")

  -- setup client specific keymap if it exists
  local has_keymap_file, current_client = pcall(require, "keymap." .. client.name)
  if has_keymap_file then
    current_client.setup(client, bufnr)
  end
end

return M

local nvim_lsp = require "lspconfig"

local on_attach = require "lsp.settings.on_attach"
local capabilities = require "lsp.settings.capabilities"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

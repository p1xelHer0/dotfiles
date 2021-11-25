local nvim_lsp = require "lspconfig"

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

nvim_lsp.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

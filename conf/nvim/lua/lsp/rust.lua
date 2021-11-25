local nvim_lsp = require "lspconfig"

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local settings = {
  ["rust-analyzer"] = {
    inlayHints = {
      typeHints = false,
    },
    diagnostics = {
      enable = false,
    },
    hoverActions = {
      enable = false,
    },
  },
}

nvim_lsp.rust_analyzer.setup {
  settings = settings,
  capabilities = capabilities,
  on_attach = on_attach,
}

local nvim_lsp = require "lspconfig"

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/p1xelher0/.nix-profile/bin/omnisharp"

nvim_lsp.omnisharp.setup {
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  capabilities = capabilities,
  on_attach = on_attach,
}

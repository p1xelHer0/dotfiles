local nvim_lsp = require "lspconfig"

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local rescript_server_binary =
  "/Users/p1xelher0/.vscode/extensions/chenglou92.rescript-vscode-1.2.0/server/out/server.js"

nvim_lsp.rescriptls.setup {
  cmd = {
    "node",
    rescript_server_binary,
    "--stdio",
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

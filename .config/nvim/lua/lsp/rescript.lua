local nvim_lsp = require "lspconfig"

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local rescript_server_binary =
  "/Users/pontusnagy/.local/share/nvim/site/pack/packer/opt/vim-rescript/server/out/server.js"

nvim_lsp.rescriptls.setup {
  cmd = {
    "node",
    rescript_server_binary,
    "--stdio",
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

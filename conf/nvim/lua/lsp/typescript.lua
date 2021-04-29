local nvim_lsp = require("lspconfig")

local on_attach = require("lsp.settings.on_attach")

nvim_lsp.tsserver.setup({on_attach = on_attach})

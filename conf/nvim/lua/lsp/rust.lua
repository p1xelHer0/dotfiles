local nvim_lsp = require("lspconfig")

local on_attach = require("lsp.settings.on_attach")

local settings = {
    ["rust-analyzer"] = {
        inlayHints = {
            typeHints = false
        },
        diagnostics = {
            enable = false
        },
        hoverActions = {
            enable = false
        }
    }
}

nvim_lsp.rust_analyzer.setup(
    {
        on_attach = on_attach,
        settings = settings
    }
)

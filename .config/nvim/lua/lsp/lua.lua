local nvim_lsp = require "lspconfig"

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
      -- fuck telemetry :)
      telemetry = {
        enable = false,
      },
      format = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

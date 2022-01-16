local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  return
end

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local extension_path = "$HOME/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local opts = {
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
}

rust_tools.setup { opts }

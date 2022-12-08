local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  return
end

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local extension_path = "$HOME/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

rust_tools.setup {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    runnables = {
      use_telescope = true,
    },
    debuggables = {
      use_telescope = true,
    },
    inlay_hints = {
      only_current_line = false,
      only_current_line_autocmd = "CursorHold",
      show_parameter_hints = true,
      highlight = "Comment",
    },
    hover_actions = {
      auto_focus = true,
    },
  },
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
  flags = {
    debounce_text_changes = false,
  },
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
}

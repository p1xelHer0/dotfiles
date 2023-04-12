local M = {
  "simrat39/rust-tools.nvim",
  dependencies = {
    { "neovim/nvim-lspconfig" },
  },
  ft = { "rust" },
  config = function()
    local capabilities = require("internal.lsp").capabilities()

    -- check ~/.vscode/extensions/ for correct version
    local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

    require("rust-tools").setup({
      tools = {
        autoSetHints = true,
        -- hover_with_actions = true,
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
          -- auto_focus = true,
        },
      },
      server = {
        -- cmd = { "/Users/p1xelher0/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer" },
        cmd = { "/nix/store/bc23kmwxgwlyvpxdnfr92n2kw7j67im8-rust-default-1.68.0-nightly-2022-12-13/bin/rust-analyzer" },
        capabilities = capabilities,
        on_attach = require("internal.lsp").on_attach,
        standalone = false,

        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            checkOnSave = {
              allFeatures = true,
              overrideCommand = {
                "cargo",
                "clippy",
                "--workspace",
                "--message-format=json",
                "--all-features",
              },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
      flags = {
        debounce_text_changes = false,
      },
    })
  end,
}

return M

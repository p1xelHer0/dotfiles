local on_attach = require("lsp.settings.on_attach")

local sumneko_root_path = "/Users/pontusnagy/dev/repo/private/oss/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

require("lspconfig").sumneko_lua.setup(
    {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ";")
                },
                diagnostics = {
                    globals = {"vim"}
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                },
                -- fuck telemetry :)
                telemetry = {
                    enable = false
                }
            }
        }
    }
)

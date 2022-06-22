local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local on_attach = require "lsp.settings.on_attach"

local sources = {
  -- c/cpp
  null_ls.builtins.formatting.clang_format,

  -- js
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.code_actions.eslint_d,

  -- lua
  null_ls.builtins.formatting.stylua,

  -- null_ls.builtins.formatting.ocamlformat,
}

null_ls.setup { sources = sources, on_attach = on_attach }

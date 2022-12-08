local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local on_attach = require "lsp.settings.on_attach"

local sources = {
  -- C/CPP
  null_ls.builtins.formatting.clang_format,

  -- JavaScript
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.code_actions.eslint_d,

  -- Lua
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.selene,

  -- OCaml
  null_ls.builtins.formatting.ocamlformat,

  -- writing
  null_ls.builtins.diagnostics.proselint,
  null_ls.builtins.code_actions.proselint,
}

null_ls.setup { sources = sources, on_attach = on_attach }

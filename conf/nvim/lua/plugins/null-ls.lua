local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local on_attach = require "lsp.settings.on_attach"

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.ocamlformat,
}

null_ls.setup { sources = sources, on_attach = on_attach }

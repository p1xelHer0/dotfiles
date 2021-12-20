local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.nixfmt,
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.stylua,
}

null_ls.setup { sources = sources }

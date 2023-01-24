return {
  config = function()
    local null_ls = require("null-ls")
    local lspconfig = require("lspconfig")
    local on_attach = require("internal.lsp").on_attach

    local diagnostics = null_ls.builtins.diagnostics
    -- local hover = null_ls.builtins.hover
    local actions = null_ls.builtins.code_actions

    local sources = {
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,

      diagnostics.misspell.with({
        filetypes = { "markdown", "text", "txt" },
        args = { "$FILENAME" },
      }),
      diagnostics.write_good.with({
        filetypes = { "markdown", "tex", "" },
        extra_filetypes = { "txt", "text" },
        args = { "--text=$TEXT", "--parse" },
        command = "write-good",
      }),
      diagnostics.proselint.with({
        filetypes = { "markdown", "tex" },
        extra_filetypes = { "txt", "text" },
        command = "proselint",
        args = { "--json" },
      }),
      actions.proselint.with({ filetypes = { "markdown", "tex" }, command = "proselint", args = { "--json" } }),
    }

    local function add_builtin_if_exists(bin, type)
      if vim.fn.exepath(bin) ~= "" then
        table.insert(sources, null_ls.builtins[type][bin])
        lprint("add builtin " .. type .. "." .. bin)
      end
    end

    local d = "diagnostics"
    -- local ca = "code_actions"
    local fmt = "formatting"

    add_builtin_if_exists("eslint_d", d)
    -- add_builtin_if_exists("selene", d)
    add_builtin_if_exists("shellcheck", d)

    add_builtin_if_exists("ocamlformat", fmt)
    add_builtin_if_exists("prettierd", fmt)
    add_builtin_if_exists("rustfmt", fmt)
    add_builtin_if_exists("shfmt", fmt)
    add_builtin_if_exists("stylua", fmt)

    local config = {
      sources = sources,
      fallback_severity = vim.diagnostic.severity.WARN,
      root_dir = lspconfig.util.root_pattern(
        ".null-ls-root",
        "Makefile",
        ".git",
        "package.json",
        "tsconfig.json",
        "*.opam",
        "dune-project",
        "esy.json"
      ),
      on_attach = on_attach,
    }

    null_ls.setup(config)
  end,
}

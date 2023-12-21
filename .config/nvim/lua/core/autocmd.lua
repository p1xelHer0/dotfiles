local M = {}
local api = vim.api
local group = api.nvim_create_augroup("internal.autocmd", {})

-- Don't list quickfix buffers
api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
})

-- Hide cursorline in Insert mode
api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = group,
  pattern = "*",
  callback = function()
    if vim.opt_local.cursorline:get() then
      vim.opt_local.cursorline = false
    end
  end,
})

-- Show cursorline in Insert mode
api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = group,
  pattern = "*",
  callback = function()
    if not vim.opt_local.cursorline:get() then
      vim.opt_local.cursorline = true
    end
  end,
})

-- Disable diagnostics in .env files - shellcheck is overly aggresive here
api.nvim_create_autocmd("BufEnter", {
  pattern = ".env**",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

api.nvim_create_autocmd("BufEnter", {
  pattern = "**.ss",
  group = group,
  callback = function(args)
    -- stylua: ignore start
    -- https://github.com/mighty-gerbils/gerbil/blob/master/etc/gerbil-mode.el
    vim.opt_local.lispwords:append({
      "import", "export", "declare", "include",
      "module", "extern", "cond-expand", "require", "provide",
      "if", "apply", "eval", "set!",
      "when", "unless", "not",
      "case-lambda",
      "core-syntax-case", "core-ast-case",
      "syntax-case", "ast-case", "ast-rules",
      "identifier-rules",
      "core-match",
      "with-syntax", "with-syntax*",
      "with-ast", "with-ast*",
      "call/cc", "call/values",
      "begin-syntax", "begin-annotation", "begin0",
      "let-values", "letrec-values", "letrec*-values",
      "letrec*", "rec",
      "quote", "quasiquote", "unquote", "unquote-splicing",
      "parameterize", "syntax-parameterize",
      "quote-syntax",
      "syntax", "quasisyntax", "unsyntax", "unsyntax-splicing",
      "syntax/loc",
      "define-values", "define-alias",
      "alet", "alet*",
      "error", "raise",
      "let/cc", "let/esc",
      "unwind-protect",
      "begin-foreign", "begin-ffi",
      "cut",
      "with", "with*",
      "match", "match*",
      "sync", "wait",
      "foldl", "foldr", "andmap", "ormap",
      "type-of",
      "spawn", "spawn*", "spawn/name", "spawn/group",
      -- sugar
      "try", "finally", "catch", "with-destroy",
      "while", "until", "defmethod/alias",
      "with-methods", "with-class-methods", "with-class-method",
      "hash", "hash-eq", "hash-eqv", "let-hash", "assert!", "awhen",
      "chain", "is",
      -- coroutines
      "continue", "yield", "coroutine",
      -- iterators
      "for", "for*", "for/collect", "for/fold",
      -- actor messaging
      "<-", "<<", "->", "->>", "-->", "-->?",
      "with-result",
      -- test
      "run-tests!", "test-suite", "test-case",
      "check", "checkf", "check-eq?", "check-not-eq?", "check-eqv?",
      "check-not-eqv?", "check-equal?", "check-not-equal?",
      "check-output", "check-predicate", "check-exception",
    -- stylua: ignore end
    })
  end,
})

-- Set tmux title to current Neovim buffer
if vim.env.TMUX then
  api.nvim_create_autocmd({ "BufReadPost", "FileReadPost", "BufNewFile", "BufEnter", "FocusGained" }, {
    pattern = "*",
    group = group,
    callback = function()
      local buffer_name = vim.fn.expand("%:t")
      vim.fn.system(string.format([[tmux rename-window %s]], buffer_name))
    end,
  })

  api.nvim_create_autocmd({ "VimLeave", "FocusLost" }, {
    pattern = "*",
    group = group,
    callback = function()
      vim.fn.system([[tmux setw automatic-rename]])
    end,
  })
end

M.silicon_setup = function()
  api.nvim_create_augroup("internal.autocmd.silicon_refresh", { clear = true })

  api.nvim_create_autocmd({ "ColorScheme" }, {
    group = "internal.autocmd.silicon_refresh",
    callback = function()
      local silicon_utils = require("silicon_utils")
      silicon_utils.build_tmTheme()
      silicon_utils.reload_silicon_cache({ async = true })
    end,
    desc = "Reload silicon themes cache on colorscheme switch",
  })
end

return M

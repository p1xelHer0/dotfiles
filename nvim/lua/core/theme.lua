-- local lush = require("lush")
-- local theme = require("theme.dark")
-- lush(theme)
--

local M = {}

function M.telescope()
  local hl = vim.api.nvim_set_hl
end

function M.setup()
  local border = {
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
  }

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "CmpDocumentationBorder" })
end

return M

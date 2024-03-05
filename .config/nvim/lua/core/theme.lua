-- local lush = require("lush")
-- local theme = require("theme.dark")
-- lush(theme)
--

local M = {}

function M.telescope()
  local hl = vim.api.nvim_set_hl

  hl(0, "TelescopePreviewBorder", { link = "NormalFloat" })
  hl(0, "TelescopePreviewNormal", { link = "NormalFloat" })
  hl(0, "TelescopePreviewTitle", { link = "DiagnosticSignHint" })

  hl(0, "TelescopeResultsBorder", { link = "NormalFloat" })
  hl(0, "TelescopeResultsNormal", { link = "NormalFloat" })
  hl(0, "TelescopeResultsTitle", { link = "DiagnosticSignInfo" })

  hl(0, "TelescopePromptBorder", { link = "NormalFloat" })
  hl(0, "TelescopePromptNormal", { link = "NormalFloat" })
  hl(0, "TelescopePromptTitle", { link = "DiagnosticSignOk" })
  hl(0, "TelescopePromptCounter", { link = "Number" })
  hl(0, "TelescopePromptPrefix", { link = "@keyword.operator" })
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

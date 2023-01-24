local galaxyline = require("galaxyline")
local gls = galaxyline.section
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")

galaxyline.short_line_list = { "NvimTree", "vista", "dbui", "packer", "lspsagaoutline" }

gls.left[1] = {
  FileSize = {
    condition = condition.buffer_not_empty,
    highlight = "WildMenu",
    provider = "FileSize",
  },
}

gls.left[2] = {
  FileName = {
    condition = condition.buffer_not_empty,
    highlight = "WildMenu",
    provider = "FileName",
  },
}

gls.left[3] = {
  DiagnosticError = {
    highlight = "DiagnosticError",
    provider = "DiagnosticError",
  },
}

gls.left[4] = {
  DiagnosticWarn = {
    highlight = "DiagnosticWarn",
    provider = "DiagnosticWarn",
  },
}

gls.left[5] = {
  DiagnosticHint = {
    highlight = "DiagnosticHint",
    provider = "DiagnosticHint",
  },
}

gls.left[6] = {
  DiagnosticInfo = {
    highlight = "DiagnosticInfo",
    provider = "DiagnosticInfo",
  },
}

gls.mid[1] = {
  ShowLspClient = {
    condition = function()
      local tbl = { ["dashboard"] = true, [""] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    highlight = "StatusLine",
    provider = "GetLspClient",
  },
}

gls.right[1] = {
  GitBranch = {
    condition = condition.check_git_workspace,
    provider = "GitBranch",
  },
}

gls.right[2] = {
  Separator = {
    provider = function()
      return " "
    end,
  },
}

gls.right[3] = {
  DiffAdd = {
    condition = condition.hide_in_width,
    highlight = "GitSignsAdd",
    icon = "+",
    provider = "DiffAdd",
  },
}

gls.right[4] = {
  DiffModified = {
    condition = condition.hide_in_width,
    highlight = "GitSignsChange",
    icon = "~",
    provider = "DiffModified",
  },
}

gls.right[5] = {
  DiffRemove = {
    condition = condition.hide_in_width,
    highlight = "GitSignsDelete",
    icon = "-",
    provider = "DiffRemove",
  },
}

gls.right[6] = {
  FileEncode = {
    condition = condition.hide_in_width,
    highlight = "StatusLine",
    provider = "FileEncode",
  },
}

gls.right[7] = {
  FileFormat = {
    condition = condition.hide_in_width,
    highlight = "StatusLine",
    provider = "FileFormat",
    separator = " ",
  },
}
gls.right[8] = {
  LineInfo = {
    provider = "LineColumn",
  },
}

gls.right[9] = {
  PerCent = {
    highlight = "StatusLine",
    provider = "LinePercent",
    separator = " ",
  },
}

gls.short_line_left[1] = {
  BufferType = {
    highlight = { colors.blue, colors.bg, "bold" },
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
  },
}

gls.short_line_left[2] = {
  SFileName = {
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg, "bold" },
    provider = "SFileName",
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    highlight = { colors.fg, colors.bg },
    provider = "BufferIcon",
  },
}

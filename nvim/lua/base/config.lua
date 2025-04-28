local M = {}

function M.get_dotfiles_path()
  return os.getenv("HOME") .. "/dotfiles"
end

function M.get_lazy_path()
  return vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
end

function M.get_lazy_repo()
  return "https://github.com/folke/lazy.nvim.git"
end

function M.lazy_file_event()
  return { "BufReadPost", "BufNewFile", "BufWritePre" }
end

function M.get_icons()
  local error = "e"
  local warn = "w"
  local info = "i"
  local hint = "h"
  local ok = "o"
  local done = "🎉"
  local working = ""
  local removed = "🗑"
  local moved = "🚚"
  local definition = "🧬"
  local reference = "📑"
  local link = "📎"
  local unsaved = "📝"
  local text = "📜"
  local path = "🐾"
  local home = "🏡"
  local spell = "📚"
  local snippet = "💌"
  local indent = "│"
  local gutter = "▎"

  return {
    diagnostics = {
      Error = error,
      Warn = warn,
      Info = info,
      Hint = hint,
      Ok = ok,
    },
    severity = {
      error,
      warn,
      info,
      hint,
    },
    general = {
      def = definition .. " ",
      indent = indent,
      link = link .. " ",
      lsp = "🔮",
      lua = "🌔",
      path = path,
      ref = reference .. " ",
      snippet = snippet,
      text = text,
      treesitter = "🌳",
      unsaved = unsaved,
    },
    git = {
      add = gutter,
      change = gutter,
      change_delete = gutter,
      delete = "_",
      top_delete = "‾",
      ignored = "",
      modified = "~",
      removed = "-",
      renamed = '"',
      staged = "^",
      unmerged = "=",
      unstaged = "~",
      untracked = "+",
    },
    kind_icons = {
      Text = text,
      Method = "𝒎 ",
      Function = "  ",
      Constructor = "🛠",
      Field = "  ",
      Variable = "𝒙 ",
      Class = "🎓",
      Interface = "🎁",
      Module = "📦",
      Property = "🏷",
      Unit = "📏",
      Value = " ",
      Enum = "+ ",
      Keyword = "🔑",
      Snippet = " ",
      Color = "🎨",
      File = "📄",
      Reference = reference,
      Folder = "📂",
      EnumMember = "⊂ ",
      Constant = "𝛑 ",
      Struct = "* ",
      Event = "  ",
      Operator = " ",
      TypeParameter = "𝒕 ",
    },
  }
end

function M.get_options()
  return {
    scrolloff = 5,
    blend = 7,
  }
end

return M

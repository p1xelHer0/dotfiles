local M = {}

function M.get_lazy_path()
  return vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
end

function M.get_dotfiles_path()
  return os.getenv("HOME") .. "/dotfiles"
end

function M.get_icons()
  local error = "🚨"
  local warn = "🚧"
  local info = "🧵"
  local hint = "🍬"
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

  return {
    diagnostic = {
      Error = error,
      Warn = warn,
      Info = info,
      Hint = hint,
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

return M

local helper = {}
local home = os.getenv("HOME")

function helper.get_config_path()
  local config = os.getenv("XDG_CONFIG_DIR")

  if not config then
    return home .. "/.config/nvim"
  end
  return config
end

function helper.get_data_path()
  local data = os.getenv("XDG_DATA_DIR")
  if not data then
    return home .. "/.local/share/nvim"
  end
  return data
end

function helper.get_dotfiles_path()
  return home .. "/dotfiles"
end

function helper.get_cache_path()
  return vim.fn.stdpath("cache")
end

function helper.get_log_path()
  return string.format("%s%s%s", helper.get_cache_path(), "/", "nvim_debug.log")
end

function helper.get_icons()
  local error = "🚨"
  local warn = "🚧"
  local info = "🧵"
  local hint = "🍬"
  local done = "🎉"
  local working = "⏳"
  local removed = "🗑"
  local moved = "🚚"
  local definition = "🧬"
  local reference = "📑"
  local link = "📎"
  local unsaved = "📝"
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
    packer = {
      working = working .. " ",
      error = error .. " ",
      done = done .. " ",
      removed = removed .. " ",
      moved = moved .. " ",
    },
    lspsaga = {
      def = definition .. " ",
      ref = reference .. " ",
      link = link .. " ",
      indent = indent,
    },
    kind_icons = {
      Text = "📜",
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

    LSP = "",
    Treesitter = "",
    Unsaved = "",
  }
end

local colors = {
  red = "\027[31m",
  green = "\027[32m",
  orange = "\027[33m",
  navy = "\027[34m",
  magenta = "\027[35m",
  cyan = "\027[36m",
  grey = "\027[90m",
  light_grey = "\027[37m",
  peach = "\027[91m",
  light_green = "\027[92m",
  yellow = "\027[93m",
  blue = "\027[94m",
  pink = "\027[95m",
  baby_blue = "\027[96m",
}

local function color_print(color)
  return function(text)
    print(colors[color] .. text .. "\027[m")
  end
end

function helper.error(msg)
  color_print("red")(msg)
end

setmetatable(helper, {
  __index = function(_, k)
    return color_print(k)
  end,
})

return helper

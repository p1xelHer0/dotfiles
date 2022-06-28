local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local types = require "luasnip.util.types"

ls.config.set_config = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  ext_ops = {
    [types.choiceNode] = {
      active = {
        virt_text = {
          "<-",
          "Error",
        },
      },
    },
  },
}

local s, i, t, c, f =
  ls.snippet, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set(
  "n",
  "<Leader><Leader>s",
  "<cmd>source $HOME/dotfiles/.config/nvim/lua/plugins/luasnip.lua<CR>"
)

local same = function(index)
  return f(function(arg)
    -- TODO
    print(vim.inspect(arg))
    return ""
  end, { index })
end

ls.snippets = {
  all = {
    s("sametest", fmt([[example: {}, here: {}]], { i(1), same(1) })),
    s("trigger", {
      t { "After expanding, the cursor is here ->" },
      i(1),
      t { "", "After jumping forward once, cursor is here ->" },
      i(2),
      t { "", "After jumping once more, the snippet is exited there ->" },
      i(0),
    }),
    s(
      "curtime",
      f(function()
        return 1
      end)
    ),
    s("ternary", {
      i(1, "cond"),
      t " ? ",
      i(2, "then"),
      t " : ",
      i(3, "else"),
    }),
  },
  rust = {
    s(
      "modtest",
      fmt(
        [[
          #[cfg(test)]
          mod test {{
          {}

              {}
          }}
        ]],
        {
          c(1, { t "    use super::*;", t "" }),
          i(0),
        }
      )
    ),
  },
}

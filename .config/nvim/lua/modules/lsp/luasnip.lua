return {
  setup = function()
    local ls = require("luasnip")
    local dotfiles_dir = require("core.helper").get_dotfiles_path()

    require("luasnip.loaders.from_lua").load({
      paths = { dotfiles_dir .. "/.config/nvim/lua/snippets/" },
    })

    require("luasnip.loaders.from_vscode").load({})

    ls.config.set_config({
      history = false,
      updateevents = "TextChanged,TextChangedI",
    })

    vim.schedule(function()
      require("luasnip.loaders.from_vscode").load()
    end)
  end,
}

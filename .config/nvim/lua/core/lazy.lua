local M = {}

M.setup = function()
  require("lazy").setup({
    spec = {
      { import = "plugins" },
      { import = "plugins.lsp.rust" },
    },
    lockfile = require("core.config").get_dotfiles_path() .. "/.config/nvim/lazy-lock.json",
    install = { colorscheme = { "tokyonight" } },
    custom_keys = {
      ["<Leader>L"] = function()
        require("lazy").home()
      end,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "2html",
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "rplugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
end

return M

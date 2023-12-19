require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  lockfile = require("core.config").get_dotfiles_path() .. "/.config/nvim/lazy-lock.json",
  install = {
    colorscheme = {
      "oxocarbon",
    },
  },
  change_detection = {
    notify = false,
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

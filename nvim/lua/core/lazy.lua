require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  lockfile = require("core.config").get_dotfiles_path() .. "/nvim/lazy-lock.json",
  install = {
    colorscheme = {
      "colors",
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

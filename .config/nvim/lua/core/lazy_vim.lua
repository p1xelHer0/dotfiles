local M = {}

M.setup = function()
  require("lazy").setup("plugins", {
    install = { colorscheme = { "tokyonight", "habamax" } },
    performance = {
      rtp = {
        disabled_plugins = {
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

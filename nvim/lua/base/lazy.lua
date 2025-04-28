local base_config = require("base.config")
local lazy_path = base_config.get_lazy_path()

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local lazy_repo = base_config.get_lazy_repo()
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazy_path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = {
    colorscheme = {
      "zenbones",
    },
  },
  change_detection = {
    notify = false,
  },
})

local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { desc = "Lazy: " .. desc })
end

-- stylua: ignore start
map("<Leader>L", function() require("lazy").home() end, "home")
-- stylua: ignore end

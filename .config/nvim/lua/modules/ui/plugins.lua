local ui = {}
local conf = require("modules.ui.config")

ui["f-person/auto-dark-mode.nvim"] = {
  config = conf.auto_dark_mode,
  requires = {
    {
      "projekt0n/github-nvim-theme",
      setup = conf.github_theme,
    },
    { "~/code/github/rktjmp/p1xel" },
  },
}

-- ui["windwp/windline.nvim"] = {
--   opt = true,
-- }

-- ui["glepnir/galaxyline.nvim"] = {
--   opt = true,
-- }

ui["kyazdani42/nvim-tree.lua"] = {
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  config = conf.nvim_tree,
  opt = true,
}

ui["lukas-reineke/indent-blankline.nvim"] = {
  cmd = {
    "IndentBlanklineToggle",
    "IndentBlanklineEnable",
    "IndentBlanklineDisable",
    "IndentBlanklineRefresh",
    "IndentBlanklineRefreshScroll",
  },
  config = conf.blankline,
  opt = true,
}

return ui

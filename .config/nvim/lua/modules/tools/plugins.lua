local tools = {}
local conf = require("modules.tools.config")

tools["rktjmp/lush.nvim"] = {}

tools["rktjmp/shipwright.nvim"] = {}

tools["christoomey/vim-tmux-navigator"] = {
  opt = true,
}

tools["nvim-telescope/telescope.nvim"] = {
  config = conf.telescope,
  setup = conf.telescope_preload,
  requires = {
    { "nvim-lua/plenary.nvim", opt = true },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
    { "nvim-telescope/telescope-live-grep-args.nvim", opt = true },
    { "nvim-telescope/telescope-file-browser.nvim", opt = true },
  },
  opt = true,
}

tools["ThePrimeagen/harpoon"] = {
  opt = true,
  config = function()
    require("harpoon").setup({
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
      },
    })
    require("telescope").load_extension("harpoon")
  end,
}

tools["TimUntersberger/neogit"] = {
  cmd = { "Neogit" },
  config = conf.neogit,
}

tools["sindrets/diffview.nvim"] = {
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewFocusFiles",
    "DiffviewToggleFiles",
    "DiffviewRefresh",
  },
  config = conf.diffview,
}

tools["lewis6991/gitsigns.nvim"] = {
  config = conf.gitsigns,
  opt = true,
}

tools["rbong/vim-flog"] = {
  cmd = { "Flog", "Flogsplit" },
  opt = true,
}

tools["tpope/vim-fugitive"] = {
  cmd = {
    "Gvsplit",
    "Git",
    "Gedit",
    "Gstatus",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Flog",
    "Flogsplit",
  },
  opt = true,
}

tools["iamcco/markdown-preview.nvim"] = {
  cmd = { "MarkdownPreview" },
  ft = { "markdown", "pandoc.markdown", "rmd" },
  opt = true,
  run = [[sh -c "cd app && yarn install"]],
  setup = conf.mkdp,
}

tools["tpope/vim-repeat"] = {
  opt = true,
}

tools["ahmedkhalf/project.nvim"] = {
  after = { "telescope.nvim" },
  config = conf.project,
  opt = true,
}

tools["jvgrootveld/telescope-zoxide"] = {
  after = { "telescope.nvim" },
  config = function()
    require("modules.tools.telescope")
    require("telescope").load_extension("zoxide")
  end,
  opt = true,
}

tools["AckslD/nvim-neoclip.lua"] = {
  opt = true,
  requires = { "kkharji/sqlite.lua", module = "sqlite" },
  config = function()
    require("modules.tools.telescope")
    require("neoclip").setup({ db_path = require("core.helper").get_data_path() .. "/databases/neoclip.sqlite3" })
    require("telescope").load_extension("neoclip")
  end,
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
  requires = { "kkharji/sqlite.lua", module = "sqlite", opt = true },
  opt = true,
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("frecency")
    telescope.setup({
      extensions = {
        frecency = {
          default_workspace = "CWD",
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*" },
          disable_devicons = true,
          workspaces = {
            -- ["conf"] = "/home/my_username/.config",
            -- ["data"] = "/home/my_username/.local/share",
            -- ["project"] = "/home/my_username/projects",
            -- ["wiki"] = "/home/my_username/wiki"
          },
        },
      },
    })
  end,
}

return tools

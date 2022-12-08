local tools = {}
local conf = require("modules.tools.config")

tools["christoomey/vim-tmux-navigator"] = {
  opt = true,
}

tools["kristijanhusak/vim-dadbod-ui"] = {
  cmd = { "DBUIToggle", "DBUIAddConnection", "DBUI", "DBUIFindBuffer", "DBUIRenameBuffer", "DB" },
  config = conf.vim_dadbod_ui,
  requires = { "tpope/vim-dadbod", ft = { "sql" } },
  opt = true,
  setup = function()
    vim.g.dbs = {
      eraser = "postgres://postgres:password@localhost:5432/eraser_local",
      staging = "postgres://postgres:password@localhost:5432/my-staging-db",
      wp = "mysql://root@localhost/wp_awesome",
    }
  end,
}

tools["ThePrimeagen/git-worktree.nvim"] = {
  event = { "CmdwinEnter", "CmdlineEnter" },
  config = conf.worktree,
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

tools['pwntester/octo.nvim'] = {
  cmd = { 'Octo', 'Octo pr list' },
  config = function()
    require "octo".setup()
  end
}

tools["TimUntersberger/neogit"] = {
  cmd = { "Neogit" },
  config = conf.neogit,
}

tools["liuchengxu/vista.vim"] = { cmd = "Vista", setup = conf.vim_vista, opt = true }

tools["plasticboy/vim-markdown"] = {
  ft = "markdown",
  requires = { "godlygeek/tabular" },
  cmd = { "Toc" },
  setup = conf.markdown,
  opt = true,
}

tools["iamcco/markdown-preview.nvim"] = {
  ft = { "markdown", "pandoc.markdown", "rmd" },
  cmd = { "MarkdownPreview" },
  setup = conf.mkdp,
  run = [[sh -c "cd app && yarn install"]],
  opt = true,
}

tools["nanotee/zoxide.vim"] = { cmd = { "Z", "Lz", "Zi" } }

tools["liuchengxu/vim-clap"] = {
  cmd = { "Clap" },
  run = function()
    vim.fn["clap#installer#download_binary"]()
  end,
  setup = conf.clap,
  config = conf.clap_after,
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
  -- keys = {']c', '[c'},  -- load by lazy.lua
  opt = true,
}

tools["akinsho/git-conflict.nvim"] = {
  cmd = {
    "GitConflictListQf",
    "GitConflictChooseOurs",
    "GitConflictChooseTheirs",
    "GitConflictChooseBoth",
    "GitConflictNextConflict",
  },
  opt = true,
  config = conf.git_conflict,
}

tools["rbong/vim-flog"] = {
  cmd = { "Flog", "Flogsplit" },
  opt = true,
}

tools["tpope/vim-fugitive"] = {
  cmd = { "Gvsplit", "Git", "Gedit", "Gstatus", "Gdiffsplit", "Gvdiffsplit", "Flog", "Flogsplit" },
  opt = true,
}

tools["tpope/vim-repeat"] = {
  opt = true,
}

tools["kevinhwang91/nvim-bqf"] = {
  opt = true,
  event = { "CmdlineEnter", "QuickfixCmdPre" },
  config = conf.bqf,
}

tools["ahmedkhalf/project.nvim"] = {
  opt = true,
  after = { "telescope.nvim" },
  config = conf.project,
}

tools["jvgrootveld/telescope-zoxide"] = {
  opt = true,
  after = { "telescope.nvim" },
  config = function()
    require("utils.telescope")
    require("telescope").load_extension("zoxide")
  end,
}

tools["AckslD/nvim-neoclip.lua"] = {
  opt = true,
  requires = { "kkharji/sqlite.lua", module = "sqlite" },
  config = function()
    require("utils.telescope")
    require("neoclip").setup({ db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3" })
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
          disable_devicons = false,
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

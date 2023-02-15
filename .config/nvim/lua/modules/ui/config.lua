local config = {}

function config.github_theme()
  require("github-theme").setup({
    function_style = "italic",
    sidebars = { "nvimtree", "qf", "terminal", "packer" },
  })
end

function config.auto_dark_mode()
  local dark_colorscheme = "github_dark_default"
  -- local dark_colorscheme = "p1xel"
  local light_colorscheme = "github_light_default"
  -- local light_colorscheme = "p1xel"
  local auto_dark_mode = require("auto-dark-mode")
  auto_dark_mode.setup({
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd.colorscheme(dark_colorscheme)
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd.colorscheme(light_colorscheme)
    end,
  })
  auto_dark_mode.init()
end

function config.nvim_tree()
  require("nvim-tree").setup({
    sync_root_with_cwd = false,
    git = { ignore = false },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "/",
            open = "—",
            empty = "\\",
            empty_open = "-",
            symlink = ">",
            symlink_open = "v",
          },
          git = {
            deleted = "-",
            renamed = '"',
            staged = "^",
            unmerged = "=",
            unstaged = "~",
            untracked = "+",
            ignored = "",
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
  })
end

function config.tokyonight()
  vim.g.tokyonight_style = "moon"
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_sidebars = { "qf", "terminal", "packer" }
  vim.g.tokyonight_transparent = true
end

function config.blankline()
  require("indent_blankline").setup({})
end

return config

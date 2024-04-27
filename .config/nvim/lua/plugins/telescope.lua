local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "ThePrimeagen/harpoon",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
  },
  cmd = { "Telescope" },
  keys = {
    {
      mode = "n",
      "<C-p>",
      "<Cmd>lua require 'plugins.telescope'.project_files()<CR>",
      { noremap = true, silent = true },
    },
    {
      mode = "n",
      "<Leader>P",
      "<Cmd>Telescope find_files<CR>",
      { noremap = true, silent = true },
    },
    {
      mode = "n",
      "<Leader>b",
      "<Cmd>Telescope buffers<CR>",
      { silent = true, noremap = true },
    },
    {
      mode = "n",
      "<Leader>d",
      "<Cmd>Telescope diagnostics<CR>",
      { silent = true },
    },
    {
      mode = "n",
      "<Leader>f",
      "<Cmd>Telescope live_grep<CR>",
      { silent = true },
    },
    {
      mode = "n",
      "<Leader>F",
      "<Cmd>Telescope grep_string<CR>",
      { silent = true },
    },
    {
      mode = "n",
      "<Leader>gs",
      "<Cmd>Telescope git_status<CR>",
      { silent = true },
    },
    {
      mode = "n",
      "<Leader>h",
      "<Cmd>Telescope harpoon marks<CR>",
      { silent = true },
    },
    {
      mode = "n",
      "<Leader>T",
      "<Cmd>Telescope<CR>",
      { silent = true, noremap = true },
    },
    {
      mode = "n",
      "<Leader>sh",
      "<Cmd>Telescope help_tags<CR>",
      { silent = true, noremap = true },
    },
  },
  opts = function()
    -- local borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    local borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
    local dropdown_configs = {
      layout_strategy = "vertical",
      layout_config = {
        prompt_position = "bottom",
        vertical = {
          width = 0.8,
          height = 100,
        },
      },
    }

    return {
      defaults = {
        mappings = {
          n = {
            ["q"] = "close",
          },
        },
        borderchars = borderchars,
      },
      pickers = {
        find_files = {
          hidden = true,
          -- no_ignore = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          mappings = {
            n = {
              ["dd"] = "delete_buffer",
            },
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(dropdown_configs),
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").load_extension("harpoon")
    require("telescope").setup(opts)
    require("core.theme").telescope()
  end,
}

local is_inside_work_tree = {}

M.project_files = function()
  local opts = {}
  local builtin = require("telescope.builtin")

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

return M

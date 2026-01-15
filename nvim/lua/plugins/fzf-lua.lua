local O = require("p1xelHer0.config").options()

local k = "plugins.fzf-lua: "

local M = {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = {
      { "hide", "telescope" }, -- hide: restore the picker state entirely
      -- fzf_colors = true,
      winopts = {
        preview = {
          winopts = {},
        },
      },
      fzf_opts = {
        ["--no-info"] = "",
        ["--info"] = "hidden",
        ["--padding"] = "2,1,1,2",
        ["--no-header"] = "",
        ["--no-scrollbar"] = "",
      },
      formatter = "path.filename_first",
      previewers = {
        builtin = {
          syntax_limit_b = O.bigfile_size,
        },
      },
      grep = {
        rg_glob = true, -- enable glob parsing
        glob_flag = "--iglob", -- case insensitive globs
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
      },
      lsp = {
        symbols = {
          locate = true,
        },
      },
      diagnostics = {
        prompt = "Diagnostics",
        severity_limit = "error",
      },
      keymap = {
        builtin = {
          true, -- inherit default keymaps
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-d"] = "preview-page-down",
        },
        fzf = {
          true, -- inherit default keymaps
          ["ctrl-q"] = "select-all+accept",
        },
      },
    },
    config = function(_, opts) require("fzf-lua").setup(opts) end,
    keys = {
      -- stylua: ignore start
      { "<C-p>",     function() require("fzf-lua").files() end,                 desc = k .. "Find Files" },
      { "<Leader>f", function() require("fzf-lua").live_grep_native() end,      desc = k .. "Grep" },
      { "<Leader>F", function() require("fzf-lua").grep_cword() end,            desc = k .. "Visual selection or word", mode = { "n", "x" } },
      { "<Leader>T", function() require("fzf-lua").builtin() end,               desc = k .. "FzfLua Builtins", mode = { "n", "x" } },
      { "<Leader>b", function() require("fzf-lua").buffers() end,               desc = k .. "Buffers" },
      { "<Leader>d", function() require("fzf-lua").diagnostics_workspace() end, desc = k .. "Diagnostics" },
      { "<Leader>D", function() require("fzf-lua").diagnostics_document() end,  desc = k .. "Buffer Diagnostics" },
      { "<Leader>:", function() require("fzf-lua").command_history() end,       desc = k .. "Command History" },
      { "<Leader>r", function() require("fzf-lua").resume() end,                desc = k .. "Resume" },
      { "<Leader>z", function() require("fzf-lua").zoxide() end,                desc = k .. "Zoxide" },
      -- stylua: ignore end
    },
  },
}

return M

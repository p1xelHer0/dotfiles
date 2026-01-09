local M = {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = {
      { "hide", "telescope" }, -- hide: restore the picker state entirely
      fzf_colors = true,
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
      { "<C-p>",     function() require("fzf-lua").files() end,                 desc = "Find Files" },
      { "<Leader>f", function() require("fzf-lua").live_grep_native() end,      desc = "Grep" },
      { "<Leader>F", function() require("fzf-lua").grep_cword() end,            desc = "Visual selection or word", mode = { "n", "x" } },
      { "<Leader>T", function() require("fzf-lua").builtin() end,               desc = "FzfLua Builtins", mode = { "n", "x" } },
      { "<Leader>b", function() require("fzf-lua").buffers() end,               desc = "Buffers" },
      { "<Leader>d", function() require("fzf-lua").diagnostics_workspace() end, desc = "Diagnostics" },
      { "<Leader>D", function() require("fzf-lua").diagnostics_document() end,  desc = "Buffer Diagnostics" },
      { "<Leader>:", function() require("fzf-lua").command_history() end,       desc = "Command History" },
      { "<Leader>r", function() require("fzf-lua").resume() end,                desc = "Resume" },
      { "<Leader>z", function() require("fzf-lua").zoxide() end,                desc = "Zoxide" },
      -- stylua: ignore end
    },
  },
}

return M

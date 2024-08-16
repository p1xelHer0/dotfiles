local M = {}
local api = vim.api
local group = api.nvim_create_augroup("internal.autocmd", {})

-- Don't list quickfix buffers
api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
})

-- Hide cursorline in Insert mode
if vim.opt_local.cursorline:get() then
  api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
      if vim.opt_local.cursorline:get() then
        vim.opt_local.cursorline = false
      end
    end,
  })

  -- Show cursorline in Insert mode
  api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = group,
    pattern = "*",
    callback = function()
      if not vim.opt_local.cursorline:get() then
        vim.opt_local.cursorline = true
      end
    end,
  })
end

-- Disable diagnostics in .env files - shellcheck is overly aggresive here
api.nvim_create_autocmd("BufEnter", {
  pattern = ".env**",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

api.nvim_create_autocmd("BufEnter", {
  pattern = "**/.config/alacritty/*.toml",
  group = group,
  callback = function(args)
    require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
  end,
})

api.nvim_create_autocmd("BufEnter", {
  pattern = "**/lush_theme/colors.lua",
  group = group,
  callback = function(args)
    vim.cmd([[Lushify]])
  end,
})

-- Set tmux title to current Neovim buffer
if vim.env.TMUX then
  api.nvim_create_autocmd({ "BufReadPost", "FileReadPost", "BufNewFile", "BufEnter", "FocusGained" }, {
    pattern = "*",
    group = group,
    callback = function()
      local buffer_name = vim.fn.expand("%:t")
      vim.fn.system(string.format([[tmux rename-window %s]], buffer_name))
    end,
  })

  api.nvim_create_autocmd({ "VimLeave", "FocusLost" }, {
    pattern = "*",
    group = group,
    callback = function()
      vim.fn.system([[tmux setw automatic-rename]])
    end,
  })
end

return M

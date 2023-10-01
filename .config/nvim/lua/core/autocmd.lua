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

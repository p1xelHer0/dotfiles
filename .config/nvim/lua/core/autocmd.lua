local api = vim.api
local group = api.nvim_create_augroup("internal.autocmd", {})

api.nvim_create_autocmd({ "BufWritePre" }, {
  group = group,
  pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
  callback = function()
    vim.opt_local.undofile = false
  end,
})

api.nvim_create_autocmd("BufRead", {
  group = group,
  pattern = "*.conf",
  callback = function()
    api.nvim_buf_set_option(0, "filetype", "conf")
  end,
})

api.nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
})

api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = group,
  pattern = "*",
  callback = function()
    if not vim.opt_local.cursorline:get() then
      vim.opt_local.cursorline = true
    end
  end,
})

api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = group,
  pattern = "*",
  callback = function()
    if vim.opt_local.cursorline:get() then
      vim.opt_local.cursorline = false
    end
  end,
})

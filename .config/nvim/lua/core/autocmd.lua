local api = vim.api
local group = api.nvim_create_augroup("internal.autocmd", {})

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

api.nvim_create_autocmd("BufEnter", {
  pattern = ".env**",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

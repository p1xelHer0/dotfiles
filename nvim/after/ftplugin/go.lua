-- we only ever have tabs in Go files: hide them
-- stylua: ignore start
vim.bo.tabstop          = 2
vim.local_opt.listchars = { tab = "  " }
-- stylua: ignore end

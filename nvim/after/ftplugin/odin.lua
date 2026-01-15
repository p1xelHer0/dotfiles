local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=odin: " .. desc })
end

-- stylua: ignore start
map("<Leader>s",      ":!./b -- hot_reload<CR>",                                                     "build hot reload DLL")
map("<LocalLeader>s", ":!odin run % -file -debug -- run metagen_rebuild hot_reload<CR>",             "build hot reload DLL")
map("<Leader>c",      "o////////////////////////////////////////<ESC>",                              "comment section")
-- stylua: ignore end

-- stylua: ignore start
vim.bo.tabstop          = 2
vim.opt_local.listchars = { tab = "  " }
-- stylua: ignore end

vim.lsp.enable("ols")

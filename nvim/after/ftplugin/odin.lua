local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=odin: " .. desc })
end

-- stylua: ignore start
map("<Leader>s",      ":!./build_hot_reload.sh<CR>",                                                 "build hot reload DLL")
map("<LocalLeader>s", ":!odin run % -file -- run metagen_rebuild<CR>",                               "build hot reload DLL")
map("<Leader>S",      ":!odin build ./src/metagen -out:./bin/metagen -o:speed -no-bounds-check<CR>", "build metagen")
map("<Leader>c",      "o////////////////////////////////////////<ESC>",                              "comment section")
-- stylua: ignore end

-- stylua: ignore start
vim.bo.tabstop          = 2
vim.local_opt.listchars = { tab = "  " }
-- stylua: ignore end

vim.lsp.enable("ols")

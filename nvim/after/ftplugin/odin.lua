local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=odin: " .. desc })
end

-- stylua: ignore start
map("<Leader>s",      ":!./build_hot_reload.sh<CR>",                                                 "Build hot reload DLL")
map("<LocalLeader>s", ":!odin run % -file -- run metagen_rebuild<CR>",                               "Build hot reload DLL")
map("<Leader>S",      ":!odin build ./src/metagen -out:./bin/metagen -o:speed -no-bounds-check<CR>", "Build metagen")
map("<Leader>c",      "o////////////////////////////////////////<ESC>",                              "Comment section")
-- stylua: ignore end

-- stylua: ignore start
vim.o.tabstop      = 2
vim.opt.listchars  = { tab = "  " }
-- stylua: ignore end

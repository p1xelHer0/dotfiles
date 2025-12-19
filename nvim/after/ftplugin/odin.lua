local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=odin: " .. desc })
end

-- stylua: ignore start
map("<Leader>s", ":!./build_hot_reload.sh<CR>", "Build hot reload DLL")
map("<Leader>S", ":Lazy reload colors<CR>", "Reload colors")
-- map("<Leader>s",      ":!odin run ./sim86 -debug -- part_1/listing_0039_more_movs<CR>", "Build perf_aware part_1")
map("<Leader>c",      "o////////////////////////////////////////<ESC>",                           "Comment section")
map("<Localleader>f", "ebyeofmt.printfln(\"<ESC>pa: %v\", <ESC>pa)<ESC>",                         "`fmt.printfln` current word")
map("<Localleader>f", "yeofmt.printfln(\"<ESC>pa: %v\", <ESC>pa)<ESC>",                           "`fmt.printfln` current word - {v}", "v")
-- stylua: ignore end

-- stylua: ignore start
vim.opt.shiftwidth = 2
vim.opt.tabstop    = 2
vim.opt.listchars  = {
  eol              = " " ,
  tab              = "  ",
  trail            = "·" ,
  extends          = "→" ,
  precedes         = "←" ,
  nbsp             = "␣" ,
}
-- stylua: ignore end

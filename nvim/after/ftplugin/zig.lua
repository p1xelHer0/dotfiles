local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=c: " .. desc })
end

-- stylua: ignore start
map("<Leader>s", ":!zig build<CR>", "Zig build")
map("<Leader>c", "o////////////////////////////////////////<ESC>", "Comment section")

local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=janet: " .. desc })
end

map("<Leader>c", "o########################################<ESC>", "Comment section")

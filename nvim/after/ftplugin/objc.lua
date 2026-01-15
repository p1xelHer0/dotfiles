local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=objc: " .. desc })
end

map("<Leader>c", "o////////////////////////////////////////<ESC>", "comment section")

vim.lsp.enable("clangd")

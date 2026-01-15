local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=zig: " .. desc })
end

-- stylua: ignore start
map("<Leader>s", ":!zig build<CR>",                                "zig build")
map("<Leader>c", "o////////////////////////////////////////<ESC>", "comment section")
-- stylua: ignore end

-- stylua: ignore start
vim.bo.tabstop = 4
-- stylua: ignore end

vim.lsp.enable("zls")

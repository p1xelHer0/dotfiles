local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=odin: " .. desc })
end

-- stylua: ignore start
map("<Leader>s", ":Lazy reload color<CR>", "Build")
-- stylua: ignore end

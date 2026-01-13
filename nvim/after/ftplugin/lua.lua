local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=lua: " .. desc })
end

-- stylua: ignore start
map("<Leader>s", ":Lazy reload mibo<CR>", "build")
-- stylua: ignore end

local ft_plugin_lua = vim.api.nvim_create_augroup("ftplugin.lua", {})
local autocmd = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, {
    group = ft_plugin_lua,
    pattern = pattern,
    callback = callback,
    desc = "ft=lua: " .. desc,
  })
end

vim.lsp.enable("lua_ls")

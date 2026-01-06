local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { buffer = true, desc = "ft=toml: " .. desc })
end

-- stylua: ignore start
map("<Leader>s", ":!./build.sh<CR>", "Build mibo colorscheme")
-- stylua: ignore end

local ft_plugin_toml = vim.api.nvim_create_augroup("ftplugin.toml", {})
local autocmd = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, {
    group = ft_plugin_toml,
    pattern = pattern,
    callback = callback,
    desc = "ft=toml: " .. desc,
  })
end

vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"

if vim.g.neovide == true then
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { desc = "Neovide: " .. desc })
  end

  -- stylua: ignore start
  map("<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", "toggle fullscreen")
  -- stylua: ignore end
end

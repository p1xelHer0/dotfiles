vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "Term: " .. desc })
    end

    -- stylua: ignore start
    map("<Esc>", "<C-\\><C-n>", "esc to leave insert mode", "t")
    -- stylua: ignore end
  end,
})

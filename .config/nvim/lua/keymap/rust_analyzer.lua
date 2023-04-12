local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }

  -- k("n", "K", "<Cmd>RustHoverActions<CR>", opts)
  -- k("n", "ga", "<Cmd>RustCodeAction<CR>", opts)
end

return M

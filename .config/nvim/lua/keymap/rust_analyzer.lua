local M = {}

---@param client? string
---@param bufnr? string
M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }

  -- k("n", "K", require("rust-tools").hover_actions.hover_actions, opts)
  -- k("n", "ga", "<Cmd>RustCodeAction<CR>", opts)
end

return M

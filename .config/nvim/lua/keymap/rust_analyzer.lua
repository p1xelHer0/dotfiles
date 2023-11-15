local M = {}

---@param client? string
---@param bufnr? string
M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }
  local rust = require("rust-tools")

  k("n", "K", rust.hover_actions.hover_actions, opts)
  k("n", "ga", rust.code_action_group.code_action_group, opts)
end

return M

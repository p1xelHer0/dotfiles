local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  -- Chrome keymaps
  k("n", "<F9>", require("dap").continue, { noremap = true })
  k("n", "<F10>", require("dap").step_over, { noremap = true })
  k("n", "C-'", require("dap").step_over, { noremap = true })
  k("n", "<F11>", require("dap").step_into, { noremap = true })
  k("n", "C-;", require("dap").step_into, { noremap = true })
  k("n", "S-<F11>", require("dap").step_out, { noremap = true })
  k("n", "C-S-;", require("dap").step_out, { noremap = true })
end

return M

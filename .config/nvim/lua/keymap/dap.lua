local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true }

  -- Chrome keymaps
  k("n", "<F9>", require("dap").continue, opts)
  k("n", "<F10>", require("dap").step_over, opts)
  k("n", "C-'", require("dap").step_over, opts)
  k("n", "<F11>", require("dap").step_into, opts)
  k("n", "C-;", require("dap").step_into, opts)
  k("n", "S-<F11>", require("dap").step_out, opts)
  k("n", "C-S-;", require("dap").step_out, opts)
end

return M

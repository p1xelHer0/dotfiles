local M = {}

M.setup = function()
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
  k("n", "<Leader>db", require("dap").toggle_breakpoint, opts)
  k("n", "<Leader>dB", require("dap").set_breakpoint, opts)
  k("n", "<Leader>lp", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "), opts)
  end)
  k("n", "<Leader>dr", require("dap").repl.open, opts)
  k("n", "<Leader>dl", require("dap").run_last, opts)
  k({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, opts)
  k({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview, opts)
  k("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
  end, opts)
  k("n", "<Leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
  end, opts)
end

return M

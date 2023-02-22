local M = {}

M.setup = function(client, bufnr)
  local k = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }

  k("n", "<leader>gO", "<Cmd>TypescriptOrganizeImports<CR>", opts)
  k("n", "<leader>gR", "<Cmd>TypescriptRenameFile<CR>", opts)
end

return M

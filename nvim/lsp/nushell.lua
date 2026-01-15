---@type vim.lsp.Config
return {
  cmd = { "nu", "--lsp" },
  filetypes = { "nu" },
  root_markers = { ".git" },
}

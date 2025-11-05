---@type vim.lsp.Config
return {
  cmd = { "slangd" },
  filetypes = { "slang", "hlsl", "hlsli" },
  root_markers = {
    ".git",
  },
}

---@type vim.lsp.Config
return {
  cmd = { "zls" },
  filetypes = { "zig", "zir", "zon" },
  root_markers = { "build.zig", "zls.json", ".git" },
}

---@type vim.lsp.Config
return {
  cmd = { "elm-language-server" },
  filetypes = { "elm" },
  root_markers = {
    "elm.json",
    ".git",
  },
}

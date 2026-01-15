---@type vim.lsp.Config
return {
  cmd = { "gopls" },
  filetypes = { "go" },
  settings = {
    gopls = {
      staticcheck = true,
      analyses = {
        modernize = false,
      },
    },
  },
}

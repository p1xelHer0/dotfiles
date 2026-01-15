local api = vim.api

---@type vim.lsp.Config
return {
  cmd = { "elm-language-server" },
  filetypes = { "elm" },
  root_dir = function(bufnr, on_dir)
    local fname = api.nvim_buf_get_name(bufnr)
    local filetype = vim.bo[bufnr].filetype
    if filetype == "elm" or (filetype == "json" and fname:match("elm%.json$")) then
      on_dir(vim.fs.root(fname, "elm.json"))
      return
    end
    on_dir(nil)
  end,
  init_options = {
    elmReviewDiagnostics = "error",
    skipInstallPackageConfirmation = false,
    disableElmLSDiagnostics = false,
    onlyUpdateDiagnosticsOnSave = false,
  },
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
  },
}

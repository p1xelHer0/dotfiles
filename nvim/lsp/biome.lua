---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = "biome"
    local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/biome"
    if local_cmd and vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    return vim.lsp.rpc.start({ cmd, "lsp-proxy" }, dispatchers)
  end,
  filetypes = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  root_markers = { "package-lock.json" },
}

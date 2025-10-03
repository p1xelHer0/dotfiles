-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- enable auto-complation
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })

    -- remappings
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
    end

    map("gn", vim.lsp.buf.rename, "rename")
    map("ga", vim.lsp.buf.code_action, "code action")

    local fzf_lua = require("fzf-lua")

    -- stylua: ignore start
    map("gra", function() fzf_lua.lsp_code_action() end,       "fzf - goto definition")
    map("gd",  function() fzf_lua.lsp_definitions() end,       "fzf - goto definition")
    map("gD",  function() fzf_lua.lsp_declarations() end,      "fzf - goto declaration")
    map("grr", function() fzf_lua.lsp_references() end,        "fzf - references")
    map("gri", function() fzf_lua.lsp_implementations() end,   "fzf - goto implementation")
    map("grt", function() fzf_lua.lsp_typedefs() end,          "fzf - goto type definition")
    map("gO",  function() fzf_lua.lsp_document_symbols() end,  "fzf - symbols")
    map("gS",  function() fzf_lua.lsp_workspace_symbols() end, "fzf - workspace symbols")
    -- stylua: ignore end
  end,
})

vim.lsp.enable("biome")
vim.lsp.enable("clangd")
vim.lsp.enable("elmls")
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ols")
vim.lsp.enable("tailwindcss")

-- diagnostics
vim.diagnostic.config({
  virtual_text = true,
})

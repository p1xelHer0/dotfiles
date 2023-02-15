local setup = function()
  local nvim_lspconfig = require("lspconfig")
  local helper = require("core.helper")
  local signs = helper.get_icons()

  local on_attach = require("internal.lsp").on_attach
  local capabilities = require("internal.lsp").capabilities()

  local diagnostic_signs = signs.diagnostic
  for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local severity_signs = signs.severity
  vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = {
      source = "if_many",
      prefix = "",
      format = function(diagnostic)
        return string.format("%s %s ", severity_signs[diagnostic.severity], diagnostic.message)
      end,
    },
    update_in_insert = false,
    severity_sort = true,
  })

  nvim_lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { "vim", "packer_plugins" },
        },
        format = {
          enable = false, -- prefer Stylua via null-ls
        },
        runtime = { version = "LuaJIT" },
        workspace = {
          library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
        },
        telemetry = {
          enable = false,
        },
      },
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.rescriptls.setup({
    capabilities = capabilities,
    cmd = {
      "node",
      "/Users/p1xelher0/.vscode/extensions/chenglou92.rescript-vscode-1.2.0/server/out/server.js",
      "--stdio",
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.html.setup({
    capabilities = capabilities,
    cmd = {
      "html-languageserver",
      "--stdio",
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.cssls.setup({
    capabilities = capabilities,
    cmd = {
      "css-languageserver",
      "--stdio",
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.jsonls.setup({
    capabilities = capabilities,
    cmd = {
      "json-languageserver",
      "--stdio",
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.omnisharp.setup({
    capabilities = capabilities,
    cmd = {
      "/Users/p1xelher0/.nix-profile/bin/omnisharp",
      "--languageserver",
      "--hostPID",
      tostring(vim.fn.getpid()),
      "-s",
      "useModernNet=true",
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.gopls.setup({
    cmd = { "gopls", "--remote=auto" },
    capabilities = capabilities,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
    },
    on_attach = on_attach,
  })

  nvim_lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    on_attach = on_attach,
  })

  local servers = {
    "elixirls",
    "ocamllsp",
    "pyright",
    "rnix",
    "tailwindcss",
    "taplo",
    "tsserver",
  }

  for _, server in ipairs(servers) do
    nvim_lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
end

return { setup = setup }

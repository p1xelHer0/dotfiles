local M = {}

function M.format(client, bufnr)
  return function()
    vim.lsp.buf.format({
      bufnr = bufnr,
      filter = function()
        return client.name == "null-ls"
      end,
    })
  end
end

function M.jump_to_error_next()
  return function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end
end

function M.jump_to_error_prev()
  return function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end
end

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return capabilities
end

function M.on_attach(client, bufnr)
  require("keymap.lsp").setup(client, bufnr)

  -- setup client specific keymap if it exists
  local has_keymap_file, current_client = pcall(require, "keymap." .. client.name)
  if has_keymap_file then
    current_client.setup(client, bufnr)
  end
end

return M

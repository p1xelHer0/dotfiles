local function on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap(
    "n",
    "<Leader>wa",
    "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<Leader>wr",
    "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<Leader>wl",
    "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<Leader>D",
    "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
    opts
  )
  buf_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(
    "n",
    "<Leader>ca",
    "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    opts
  )
  buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap(
    "n",
    "<Leader>e",
    "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    opts
  )
  buf_set_keymap("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap(
    "n",
    "<Leader>q",
    "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    opts
  )

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap(
      "n",
      "<Leader><Leader>f",
      "<Cmd>lua vim.lsp.buf.formatting()<CR>:w<CR>",
      opts
    )
  end

  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap(
      "v",
      "<Leader><Leader>f",
      "<Cmd>lua vim.lsp.buf.range_formatting()<CR>:w<CR>",
      opts
    )
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
              hi LspReferenceRead  cterm=bold ctermbg=16 guibg=NONE
              hi LspReferenceText  cterm=bold ctermbg=16 guibg=NONE
              hi LspReferenceWrite cterm=bold ctermbg=16 guibg=NONE
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
            ]],
      false
    )
  end
end

return on_attach

local function on_attach(client, bufnr)
  local ls_action = require "lspsaga.codeaction"
  local ls_diagnostic = require "lspsaga.diagnostic"
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, opts)
  vim.keymap.set("n", "<C-f>", function()
    ls_action.smart_scroll_with_saga(1)
  end, opts)
  vim.keymap.set("n", "<C-b>", function()
    ls_action.smart_scroll_with_saga(-1)
  end, opts)

  vim.keymap.set("n", "<Leader>rn", require("lspsaga.rename").lsp_rename, opts)

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)
  -- vim.keymap.set("n", "<leader>ca", action.code_action, opts)
  -- vim.keymap.set("v", "<leader>ca", function()
  --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  --   action.range_code_action()
  -- end, opts)
  --
  vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gh", require("telescope.builtin").lsp_references, opts)
  -- vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, opts)
  vim.keymap.set(
    "n",
    "<Leader>lr",
    require("telescope.builtin").lsp_references,
    opts
  )
  vim.keymap.set(
    "n",
    "<Leader>ls",
    require("telescope.builtin").lsp_document_symbols,
    opts
  )
  vim.keymap.set(
    "n",
    "<Leader>ld",
    require("telescope.builtin").lsp_definitions,
    opts
  )
  vim.keymap.set(
    "n",
    "<Leader>lt",
    require("telescope.builtin").lsp_type_definitions,
    opts
  )

  -- Diagnostic
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "[d", ls_diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", ls_diagnostic.goto_next, opts)

  vim.keymap.set("n", "[e", function()
    require("lspsaga.diagnostic").goto_prev {
      severity = vim.diagnostic.severity.ERROR,
    }
  end, opts)
  vim.keymap.set("n", "]e", function()
    require("lspsaga.diagnostic").goto_next {
      severity = vim.diagnostic.severity.ERROR,
    }
  end, opts)
  vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

  -- Formatting
  if client.server_capabilities.document_formatting then
    vim.keymap.set("n", "<Leader><Leader>f", vim.lsp.buf.formatting, opts)
  end
  if client.server_capabilities.document_range_formatting then
    vim.keymap.set("v", "<Leader><Leader>f", vim.lsp.buf.range_formatting, opts)
  end

  -- Workspace
  vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wl", vim.lsp.buf.list_workspace_folders, opts)

  -- Highligt
  if client.server_capabilities.document_highlight then
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

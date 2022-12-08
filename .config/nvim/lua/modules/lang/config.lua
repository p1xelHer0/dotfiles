local config = {}

function config.refactor()
  local refactor = require 'refactoring'
  refactor.setup {}

  lprint 'refactor'
  _G.ts_refactors = function()
    -- telescope refactoring helper
    local function _refactor(prompt_bufnr)
      local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
      require('telescope.actions').close(prompt_bufnr)
      require('refactoring').refactor(content.value)
    end

    local opts = require('telescope.themes').get_cursor() -- set personal telescope options
    require('telescope.pickers')
        .new(opts, {
          prompt_title = 'refactors',
          finder = require('telescope.finders').new_table {
            results = require('refactoring').get_refactors(),
          },
          sorter = require('telescope.config').values.generic_sorter(opts),
          attach_mappings = function(_, map)
            map('i', '<CR>', _refactor)
            map('n', '<CR>', _refactor)
            return true
          end,
        })
        :find()
  end
end

function config.outline()
  require('symbols-outline').setup {}
end

function config.sqls() end

function config.syntax_folding()
  local fname = vim.fn.expand '%:p:f'
  local fsize = vim.fn.getfsize(fname)
  if fsize > 1024 * 1024 then
    print 'disable syntax_folding'
    vim.api.nvim_command 'setlocal foldmethod=indent'
    return
  end
  vim.api.nvim_command 'setlocal foldmethod=expr'
  vim.api.nvim_command 'setlocal foldexpr=nvim_treesitter#foldexpr()'
end

function config.surfer()
  -- Syntax Tree Surfer
  local opts = { noremap = true, silent = true }

  -- Normal Mode Swapping:
  -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
  vim.keymap.set('n', 'vU', function()
    vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true })
  vim.keymap.set('n', 'vD', function()
    vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true })

  -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
  vim.keymap.set('n', 'vd', function()
    vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true })
  vim.keymap.set('n', 'vu', function()
    vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true })

  --> If the mappings above don't work, use these instead (no dot repeatable)
  -- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
  -- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
  -- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
  -- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)

  -- Visual Selection from Normal Mode
  vim.keymap.set('n', 'vx', '<cmd>STSSelectMasterNode<cr>', opts)
  vim.keymap.set('n', 'vn', '<cmd>STSSelectCurrentNode<cr>', opts)

  -- Select Nodes in Visual Mode
  vim.keymap.set('x', 'J', '<cmd>STSSelectNextSiblingNode<cr>', opts)
  vim.keymap.set('x', 'K', '<cmd>STSSelectPrevSiblingNode<cr>', opts)
  vim.keymap.set('x', 'H', '<cmd>STSSelectParentNode<cr>', opts)
  vim.keymap.set('x', 'L', '<cmd>STSSelectFirstChildNode<cr>', opts)

  -- Swapping Nodes in Visual Mode
  vim.keymap.set('x', '<A-j>', '<cmd>STSSwapNextVisual<cr>', opts)
  vim.keymap.set('x', '<A-k>', '<cmd>STSSwapPrevVisual<cr>', opts)
  require('syntax-tree-surfer').setup {}
end

function config.regexplainer()
  require('regexplainer').setup {
    -- 'narrative'
    mode = 'narrative', -- TODO: 'ascii', 'graphical'

    -- automatically show the explainer when the cursor enters a regexp
    auto = false,

    -- filetypes (i.e. extensions) in which to run the autocommand
    filetypes = {
      'html',
      'js',
      'cjs',
      'mjs',
      'ts',
      'jsx',
      'tsx',
      'cjsx',
      'mjsx',
      'go',
      'lua',
      'vim',
    },

    mappings = {
      toggle = '<Leader>gR',
      -- examples, not defaults:
      -- show = 'gS',
      -- hide = 'gH',
      -- show_split = 'gP',
      -- show_popup = 'gU',
    },

    narrative = {
      separator = '\n',
    },
  }
end

-- httpsL//gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

local path = vim.split(package.path, ';')

table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

function config.navigator()
  local single = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }

  local efm_cfg = require('modules.lang.efm').efm

  -- loader('aerial.nvim')
  local nav_cfg = {
    width = 0.7,
    lsp_installer = false,
    on_attach = function(client, bufnr) end,
    border = single,
    ts_fold = true,
    lsp_signature_help = true,
    combined_attach = 'their',
    lsp = {
      disable_lsp = { 'clangd', 'rust_analyzer' },
      -- code_lens = true,
      disply_diagnostic_qf = false,
      rename = { style = 'floating-preview' },
      tsserver = {
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
        },
        on_attach = function(client, bufnr, opts)
          client.server_capabilities.documentFormattingProvider = false -- allow efm to format
        end,
      },
      servers = { 'rnix', 'yamlls', 'ocamllsp' },
    },
  }
  if vim.o.ft == 'go' or vim.o.ft == 'mod' then
    nav_cfg.lsp.gopls = function()
      local go = pcall(require, 'go')
      if go then
        local cfg = require('go.lsp').config()
        cfg.on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- efm/null-ls
        end
        return cfg
      else
        return {}
      end
    end
  end

  if false then
    nav_cfg.lsp.efm = require('modules.lang.efm').efm
  else
    table.insert(nav_cfg.lsp.disable_lsp, 'efm')
  end

  vim.lsp.set_log_level 'ERROR'
  require('navigator').setup(nav_cfg)
end

function config.playground()
  require('nvim-treesitter.configs').setup {
    playground = {
      enable = true,
      disable = {},
      updatetime = 50, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = true, -- Whether the query persists across vim sessions
    },
  }
end

function config.luadev()
  vim.cmd [[vmap <leader><leader>r <Plug>(Luadev-Run)]]
end

function config.lua_dev() end

function config.go()
  require('go').setup {
    -- goimport = 'goimports', -- 'gopls'
    fillstruct = 'gopls',
    log_path = vim.fn.expand '$HOME' .. '/tmp/gonvim.log',
    lsp_codelens = false, -- use navigator
    dap_debug = true,
    goimport = 'gopls',
    dap_debug_vt = 'true',

    dap_debug_gui = true,
    test_runner = 'go', -- richgo, go test, richgo, dlv, ginkgo
    -- run_in_floaterm = true, -- set to true to run in float window.
    lsp_document_formatting = false,
    luasnip = true,
    -- lsp_on_attach = require("navigator.lspclient.attach").on_attach,
    -- lsp_cfg = true,
    -- test_efm = true, -- errorfomat for quickfix, default mix mode, set to true will be efm only
  }

  vim.cmd 'augroup go'
  vim.cmd 'autocmd!'
  vim.cmd 'autocmd FileType go nmap <leader>gb  :GoBuild'
  --  Show by default 4 spaces for a tab')
  vim.cmd 'autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4'
  --  :GoBuild and :GoTestCompile')
  -- vim.cmd('autocmd FileType go nmap <leader><leader>gb :<C-u>call <SID>build_go_files()<CR>')
  --  :GoTest')
  vim.cmd 'autocmd FileType go nmap <leader>gt  GoTest'
  --  :GoRun

  vim.cmd 'autocmd FileType go nmap <Leader><Leader>l GoLint'
  vim.cmd "autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()"

  vim.cmd 'au FileType go command! Gtn :TestNearest -v -tags=integration'
  vim.cmd 'au FileType go command! Gts :TestSuite -v -tags=integration'
  vim.cmd 'augroup END'
end

function config.ssr()
  require('ssr').setup {
    min_width = 50,
    min_height = 5,
    keymaps = {
      close = 'q',
      next_match = 'n',
      prev_match = 'N',
      replace_all = '<leader><cr>',
    },
  }
end

function config.dap()
  -- dap.adapters.node2 = {
  --   type = 'executable',
  --   command = 'node',
  --   args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
  -- }
  -- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
  -- vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
  -- require('telescope').load_extension('dap')
  -- vim.g.dap_virtual_text = true
end

function config.clangd()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.offsetEncoding = { 'utf-16' }
  require('clangd_extensions').setup {
    server = {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        require('navigator.lspclient.mapping').setup {
          client = client,
          bufnr = bufnr,
        } -- setup navigator keymaps here,
        require('navigator.dochighlight').documentHighlight(bufnr)
        require('navigator.codeAction').code_action_prompt(bufnr)
        -- otherwise, you can define your own commands to call navigator functions
      end,
    },
  }
end

return config

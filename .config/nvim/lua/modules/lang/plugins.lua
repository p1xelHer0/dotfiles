local lang = {}
local conf = require 'modules.lang.config'
local ts = require 'modules.lang.treesitter'

lang['jose-elias-alvarez/null-ls.nvim'] = {
  config = require('modules.lang.null-ls').config,
  opt = true,
}

lang['j-hui/fidget.nvim'] = {
  config = function()
    require('fidget').setup {
      sources = {
        ['null-ls'] = { ignore = true },
      },
    }
  end,
  module = 'lspconfig',
  opt = true,
}

lang['nvim-treesitter/nvim-treesitter'] = {
  config = ts.treesitter,
  opt = true,
}

lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
  config = ts.treesitter_obj,
  opt = true,
}

lang['RRethy/nvim-treesitter-textsubjects'] = {
  config = ts.textsubjects,
  opt = true,
}

lang['nvim-treesitter/nvim-treesitter-refactor'] = {
  after = 'nvim-treesitter-textobjects', -- manual loading
  config = ts.treesitter_ref, -- let the last loaded config treesitter
  opt = true,
}

lang['nvim-treesitter/nvim-treesitter-context'] = {
  opt = true,
  event = { 'CursorHold', 'WinScrolled' },
  config = function()
    require('treesitter-context').setup {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
      patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        default = {
          'class',
          'function',
          'method',
          'for', -- These won't appear in the context
          'while',
          'if',
          'switch',
          -- 'case',
        },
      },
    }
  end,
}

lang['nvim-treesitter/playground'] = {
  opt = true,
  cmd = 'TSPlaygroundToggle',
  config = conf.playground,
}

lang['p00f/nvim-ts-rainbow'] = {
  config = function()
    require('nvim-treesitter.configs').setup {
      rainbow = { enable = true, extended_mode = true },
    }
  end,
  event = { 'CursorHold', 'CursorHoldI' },
  opt = true,
}

lang['JoosepAlviste/nvim-ts-context-commentstring'] = {
  opt = true
}

lang['m-demare/hlargs.nvim'] = {
  config = function()
    require('hlargs').setup()
  end,
  opt = true,
}

lang['windwp/nvim-ts-autotag'] = {
  opt = true,
}

lang['ray-x/navigator.lua'] = {
  config = conf.navigator,
  opt = true,
  requires = { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
}

lang['glepnir/lspsaga.nvim'] = {
  cmd = {
    'Lspsaga',
  },
  config = function()
    local saga = require 'lspsaga'
    saga.init_lsp_saga {
      border_style = 'rounded',
      code_action_lightbulb = {
        enable = false,
      },
    }
  end,
  opt = true,
}

lang['mfussenegger/nvim-dap'] = {
  config = conf.dap,
  opt = true
}

lang['rcarriga/nvim-dap-ui'] = {
  cmd = 'Luadev',
  config = conf.dapui,
  opt = true,
}

lang['theHamsta/nvim-dap-virtual-text'] = {
  cmd = 'Luadev',
  opt = true,
}

lang['nvim-telescope/telescope-dap.nvim'] = {
  config = conf.dap,
  -- cmd = "Telescope",
  opt = true,
}

lang['bennypowers/nvim-regexplainer'] = {
  cmd = { 'RegexplainerToggle', 'RegexplainerShow' },
  config = conf.regexplainer,
  opt = true,
}

lang['ThePrimeagen/refactoring.nvim'] = {
  config = conf.refactor,
  opt = true,
}

lang['mtdl9/vim-log-highlighting'] = { ft = { 'text', 'txt', 'log' } }

lang['michaelb/sniprun'] = {
  run = 'bash install.sh',
  opt = true,
  module = { 'sniprun' },
  cmd = { 'SnipRun', 'SnipReset' },
  config = function()
    require('sniprun').setup {
      -- selected_interpreters = {},     --" use those instead of the default for the current filetype
      -- repl_enable = {},               --" enable REPL-like behavior for the given interpreters
      -- repl_disable = {},              --" disable REPL-like behavior for the given interpreters
      inline_messages = 1, --" inline_message (0/1) is a one-line way to display messages
      --" to workaround sniprun not being able to display anything
    }
  end,
}

lang['folke/trouble.nvim'] = {
  cmd = { 'Trouble', 'TroubleToggle' },
  config = function()
    require('trouble').setup {}
  end,
}

lang['bfredl/nvim-luadev'] = {
  cmd = 'Luadev',
  ft = 'lua',
  opt = true,
  setup = conf.luadev,
}

lang['folke/neodev.nvim'] = {
  config = conf.lua_dev,
  opt = true,
}

lang['LnL7/vim-nix'] = {
  ft = 'nix',
  opt = true,
}

lang['ocaml/vim-ocaml'] = {
  ft = 'ocaml',
  opt = true,
}

lang['ocaml/merlin'] = {
  ft = 'ocaml',
  opt = true,
}

lang['rescript-lang/vim-rescript'] = {
  ft = 'rescript',
  opt = true,
}

lang['ray-x/go.nvim'] = {
  config = conf.go,
  ft = { 'go', 'gomod' },
  module = { 'go' },
}

lang['simrat39/rust-tools.nvim'] = {
  after = { 'nvim-lspconfig' },
  config = function()
    require('rust-tools').setup {
      server = {
        on_attach = function(c, b)
          require('navigator.lspclient.mapping').setup { client = c, bufnr = b }
        end,
      },
    }
  end,
  ft = { 'rust' },
}

lang['p00f/clangd_extensions.nvim'] = {
  config = conf.clangd,
  ft = { 'c', 'cpp', 'objc', 'objcpp', 'h', 'hpp' },
  opt = true,
}

lang['ray-x/web-tools.nvim'] = {
  config = function()
    require('web-tools').setup { debug = true }
  end,
  ft = { 'html', 'javascript' },
  opt = true,
}

lang['mlochbaum/BQN'] = {
  ft = 'bqn',
  opt = true,
  rtp = 'editors/vim',
}

lang['https://git.sr.ht/~detegr/nvim-bqn'] = {
  ft = 'bqn',
}

-- lang["gcmt/wildfire.vim"] = {
--   setup = function()
--     vim.cmd([[nmap <leader>s <Plug>(wildfire-quick-select)]])
--   end,
--   fn = {'<Plug>(wildfire-fuel)', '<Plug>(wildfire-water)', '<Plug>(wildfire-quick-select)'}
-- }

-- lang['yardnsm/vim-import-cost'] = { cmd = 'ImportCost', opt = true }

-- lang['scalameta/nvim-metals'] = {requires = {"nvim-lua/plenary.nvim"}}
-- lang["lifepillar/pgsql.vim"] = {ft = {"sql", "pgsql"}}

-- lang['nanotee/sqls.nvim'] = { ft = { 'sql', 'pgsql' }, setup = conf.sqls, opt = true }

-- lang["stevearc/aerial.nvim"] = {
--   opt = true,
--   cmd = { "AerialToggle" },
--   config = conf.aerial,
-- }

-- lang['hashivim/vim-terraform'] = {
--   ft = { 'terraform' },
--   cmd = { 'Terraform', 'TerraformToggle' },
--   opt = true,
--   -- config = conf.terraform,
-- }

-- lang['smjonas/inc-rename.nvim'] = {
--   cmd = { 'IncRename' },
--   config = function()
--     require('inc_rename').setup()
--   end,
--   module = { 'inc_rename' },
--   opt = true,
-- }
--
-- lang['cshuaimin/ssr.nvim'] = {
--   config = conf.ssr,
--   module = 'ssr',
-- }
-- lang['simrat39/symbols-outline.nvim'] = {
--   cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
--   config = conf.outline,
--   opt = true,
-- }
-- lang['danymat/neogen'] = {
--   config = function()
--     require('neogen').setup { enabled = true }
--   end,
--   opt = true,
-- }

-- JqxList and JqxQuery json browsing, format
-- lang["gennaro-tedesco/nvim-jqx"] = {opt = true, cmd = {"JqxList", "JqxQuery"}}

-- lang["jbyuki/one-small-step-for-vimkind"] = { opt = true, ft = { "lua" } }
return lang

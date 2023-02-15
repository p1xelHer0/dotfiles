local lang = {}
local conf = require("modules.lang.config")
local ts = require("modules.lang.treesitter")

lang["j-hui/fidget.nvim"] = {
  config = function()
    require("fidget").setup({
      text = {
        spinner = "triangle",
        done = "✅",
      },
      window = {
        blend = 7,
      },
    })
  end,
  module = "lspconfig",
  opt = true,
}

lang["nvim-treesitter/nvim-treesitter"] = {
  config = ts.treesitter,
  opt = true,
}

lang["nvim-treesitter/nvim-treesitter-textobjects"] = {
  config = ts.treesitter_obj,
  opt = true,
}

-- lang["RRethy/nvim-treesitter-textsubjects"] = {
--   config = ts.textsubjects,
--   opt = true,
-- }

lang["nvim-treesitter/nvim-treesitter-refactor"] = {
  after = "nvim-treesitter-textobjects",
  config = ts.treesitter_ref,
  opt = true,
}

lang["nvim-treesitter/nvim-treesitter-context"] = {
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 2,
      trim_scope = "outer",
      mode = "topline",
      patterns = {
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
        },
      },
    })
  end,
  event = { "CursorHold", "WinScrolled" },
  opt = true,
}

lang["nvim-treesitter/playground"] = {
  cmd = "TSPlaygroundToggle",
  config = conf.playground,
  opt = true,
}

lang["p00f/nvim-ts-rainbow"] = {
  config = function()
    -- https://github.com/p00f/nvim-ts-rainbow/issues/30
    local enabled_list = { "clojure", "fennel", "commonlisp", "query" }
    local parsers = require("nvim-treesitter.parsers")
    local rainbow = {
      extended_mode = true,
      enable = true,
      disable = vim.tbl_filter(function(p)
        local disable = true
        for _, lang in pairs(enabled_list) do
          if p == lang then
            disable = false
          end
        end
        return disable
      end, parsers.available_parsers()),
    }

    require("nvim-treesitter.configs").setup({ rainbow = rainbow })
  end,
  event = { "CursorHold", "CursorHoldI" },
  opt = true,
}

lang["JoosepAlviste/nvim-ts-context-commentstring"] = {
  opt = true,
}

lang["m-demare/hlargs.nvim"] = {
  config = function()
    require("hlargs").setup()
  end,
  opt = true,
}

lang["windwp/nvim-ts-autotag"] = {
  opt = true,
}

lang["mfussenegger/nvim-dap"] = {
  config = conf.dap,
  opt = true,
}

lang["rcarriga/nvim-dap-ui"] = {
  cmd = "Luadev",
  config = conf.dapui,
  opt = true,
}

lang["theHamsta/nvim-dap-virtual-text"] = {
  cmd = "Luadev",
  opt = true,
}

lang["nvim-telescope/telescope-dap.nvim"] = {
  config = conf.dap,
  opt = true,
}

lang["ThePrimeagen/refactoring.nvim"] = {
  config = conf.refactor,
  opt = true,
}

lang["mtdl9/vim-log-highlighting"] = {
  ft = {
    "log",
    "text",
    "txt",
  },
}

lang["folke/trouble.nvim"] = {
  cmd = { "Trouble", "TroubleToggle" },
  config = function()
    require("trouble").setup({
      icons = false,
    })
  end,
}

lang["bfredl/nvim-luadev"] = {
  cmd = "Luadev",
  ft = "lua",
  opt = true,
  setup = conf.nvim_luadev,
}

lang["folke/neodev.nvim"] = {
  config = conf.neodev,
  opt = true,
}

lang["LnL7/vim-nix"] = {
  ft = "nix",
  opt = true,
}

lang["ocaml/vim-ocaml"] = {
  ft = "ocaml",
  opt = true,
}

lang["ocaml/merlin"] = {
  ft = "ocaml",
  opt = true,
}

lang["rescript-lang/vim-rescript"] = {
  ft = "rescript",
  opt = true,
}

lang["ray-x/go.nvim"] = {
  config = conf.go,
  ft = { "go", "gomod" },
  module = { "go" },
}

lang["simrat39/rust-tools.nvim"] = {
  after = { "nvim-lspconfig" },
  config = function()
    local capabilities = require("internal.lsp").capabilities()

    -- check ~/.vscode/extensions/ for correct version
    local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

    require("rust-tools").setup({
      tools = {
        autoSetHints = true,
        -- hover_with_actions = true,
        runnables = {
          use_telescope = true,
        },
        debuggables = {
          use_telescope = true,
        },
        inlay_hints = {
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_parameter_hints = true,
          highlight = "Comment",
        },
        hover_actions = {
          -- auto_focus = true,
        },
      },
      server = {
        -- cmd = { "/Users/p1xelher0/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer" },
        cmd = { "/nix/store/bc23kmwxgwlyvpxdnfr92n2kw7j67im8-rust-default-1.68.0-nightly-2022-12-13/bin/rust-analyzer" },
        capabilities = capabilities,
        on_attach = require("internal.lsp").on_attach,
      },
      flags = {
        debounce_text_changes = false,
      },
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })
  end,
  ft = { "rust" },
}

lang["mlochbaum/BQN"] = {
  ft = "bqn",
  opt = true,
  rtp = "editors/vim",
}

lang["https://git.sr.ht/~detegr/nvim-bqn"] = {
  ft = "bqn",
}

-- lang["plasticboy/vim-markdown"] = {
--   cmd = { "Toc" },
--   ft = "markdown",
--   opt = true,
--   requires = { "godlygeek/tabular" },
--   setup = conf.markdown,
-- }

return lang

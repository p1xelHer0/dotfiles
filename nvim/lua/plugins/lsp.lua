local M = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        opts = {
          experimental = { pathStrict = true },
          library = {
            plugins = { "nvim-dap-ui" },
            types = true,
          },
        },
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "j-hui/fidget.nvim" },
      { "jose-elias-alvarez/typescript.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = {
                enable = true,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      for name, icon in pairs(require("core.config").get_icons().diagnostics) do
        local hl = "DiagnosticSign" .. name
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        underline = true,
        signs = true,
        virtual_text = {
          source = "if_many",
          prefix = "",
          format = function(diagnostic)
            return string.format(
              "%s %s ",
              require("core.config").get_icons().severity[diagnostic.severity],
              diagnostic.message
            )
          end,
        },
        update_in_insert = false,
        severity_sort = true,
      })

      local nvim_lspconfig = require("lspconfig")
      local nvim_lspconfig_configs = require("lspconfig.configs")
      local on_attach = require("internal.lsp").on_attach
      local capabilities = require("internal.lsp").capabilities()

      nvim_lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              enable = true,
              globals = { "vim" },
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

      nvim_lspconfig.wgsl_analyzer.setup({
        cmd = { "/Users/p1xelher0/.cargo/bin/wgsl_analyzer" },
      })

      nvim_lspconfig.slangd.setup({
        cmd = {
          "/Users/p1xelher0/code/github/p1xelHer0/gamedev/sdl-game-thing/bin/slang-2025.6.1-macos-aarch64/bin/slangd",
          -- "/Users/p1xelher0/.vscode/extensions/timgjones.hlsltools-1.1.303/bin/osx-x64/ShaderTools.LanguageServer",
        },
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

      nvim_lspconfig.nil_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixpkgs-fmt" },
            },
          },
        },
      })

      nvim_lspconfig.hls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "haskell", "lhaskell", "cabal" },
      })

      -- cargo install --git https://github.com/rydesun/fennel-language-server
      require("lspconfig.configs").fennel_language_server = {
        default_config = {
          cmd = { "/Users/p1xelher0/.cargo/bin/fennel-language-server" },
          filetypes = { "fennel" },
          single_file_support = true,
          root_dir = nvim_lspconfig.util.root_pattern("fnl"),
          settings = {
            fennel = {
              workspace = {
                library = vim.api.nvim_list_runtime_paths(),
              },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
      }

      nvim_lspconfig.nil_ls.setup({
        capabilities = capabilities,
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixpkgs-fmt" },
            },
          },
        },
        on_attach = on_attach,
      })

      -- install roswell: https://github.com/roswell/roswell/wiki/Installation
      -- add ~/.roswell/bin to your $PATH
      -- install qlot, manually, not with roswell: https://github.com/fukamachi/qlot#installation
      -- ros install lem-project/lem-mailbox lem-project/micros lem-project/lem cxxxr/cl-lsp
      -- this will build all dependencies needed for cl-lsp
      -- and install it using roswell + qlot
      require("lspconfig.configs").cl_lsp = {
        default_config = {
          cmd = { "cl-lsp", "--stdio" },
          filetypes = { "lisp" },
          root_dir = nvim_lspconfig.util.root_pattern("package.lisp", "qlfile", "qlfile.lock", ".git"),
        },
      }

      nvim_lspconfig.tailwindcss.setup({
        filetypes = { "html", "elm" },
        init_options = {
          userLanguages = {
            elm = "html",
            html = "html",
          },
        },
        root_dir = require("lspconfig.util").root_pattern(".git"),
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elm = "html",
              html = "html",
            },
            classAttributes = { "class", "className", "classList", "ngClass" },
            experimental = {
              classRegex = {
                '\\bclass[\\s(<|]+"([^"]*)"',
                '\\bclass[\\s(]+"[^"]*"[\\s+]+"([^"]*)"',
                '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
                '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
                '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
                '\\bclassList[\\s\\[\\(]+"([^"]*)"',
                '\\bclassList[\\s\\[\\(]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"([^"]*)"',
                '\\bclassList[\\s\\[\\(]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"([^"]*)"',
              },
            },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            validate = true,
          },
        },
      })

      local servers = {
        "biome",
        "cl_lsp",
        "clangd",
        "clojure_lsp",
        "elixirls",
        "jsonls",
        "elmls",
        "fennel_language_server",
        "glsl_analyzer",
        "ocamllsp", -- opam install ocaml-lsp-server - usually in local switch
        "ols",
        "ts_ls",
        "roc_ls",
        "taplo",
        "zls",
        -- "ccls",
        -- "racket_langserver", -- raco pkg install racket-langserver
      }

      for _, server in ipairs(servers) do
        nvim_lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local lspconfig = require("lspconfig")
      local on_attach = require("internal.lsp").on_attach

      local actions = null_ls.builtins.code_actions
      local completion = null_ls.builtins.completion
      local diagnostics = null_ls.builtins.diagnostics
      local formatting = null_ls.builtins.formatting

      local sources = {
        formatting.stylua,
        formatting.prettierd,
        actions.gitsigns,
        actions.refactoring,
        completion.spell,
        diagnostics.write_good.with({
          filetypes = { "markdown", "tex", "" },
          extra_filetypes = { "txt", "text" },
          args = { "--text=$TEXT", "--parse" },
          command = "write-good",
        }),
        diagnostics.proselint.with({
          filetypes = { "markdown", "tex" },
          extra_filetypes = { "txt", "text" },
          command = "proselint",
          args = { "--json" },
        }),
        actions.proselint.with({
          filetypes = { "markdown", "tex" },
          command = "proselint",
          args = { "--json" },
        }),
      }

      local config = {
        sources = sources,
        fallback_severity = vim.diagnostic.severity.WARN,
        on_attach = on_attach,
      }

      null_ls.setup(config)
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    dependencies = {
      {
        "Saecki/crates.nvim",
        opts = {
          null_ls = {
            enabled = true,
            name = "crates.nvim",
          },
        },
      },
    },
    ft = "rust",
    event = "BufEnter Cargo.toml",
    opts = {
      tools = {},
      server = {
        on_attach = function(client, bufnr)
          local on_attach = require("internal.lsp").on_attach
          on_attach(client, bufnr)
        end,
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            checkOnSave = {
              allFeatures = true,
              overrideCommand = {
                "cargo",
                "clippy",
                "--workspace",
                "--message-format=json",
                "--all-features",
              },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    opts = {
      floating_window = false,
      hint_prefix = ": ",
      hint_scheme = "Function",
      hi_parameter = "LspSignatureActiveParameter",
    },
  },

  {
    enabled = false,
    "https://gitlab.com/yorickpeterse/nvim-dd.git",
    opts = {},
    config = function(_, opts)
      require("dd").setup(opts)
    end,
  },

  {
    "elm-tooling/elm-vim",
    ft = "elm",
  },

  {
    "jaawerth/fennel.vim",
    ft = "fennel",
  },

  {
    "bakpakin/janet.vim",
    ft = "janet",
    -- keys = {
    --   {
    --     mode = "n",
    --     "<Leader>s",
    --     ":%!cat %.tested<CR>:w<CR>",
    --     { noremap = true, silent = true },
    --   },
    -- },
  },

  {
    "wlangstroth/vim-racket",
    ft = "racket",
  },
}

return M

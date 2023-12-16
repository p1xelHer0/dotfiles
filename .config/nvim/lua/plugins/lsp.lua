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
            plugins = { "neotest" },
          },
        },
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "j-hui/fidget.nvim" },
      -- {
      --   "SmiteshP/nvim-navic",
      --   dependencies = {
      --     "MunifTanjim/nui.nvim",
      --   },
      --   config = true,
      -- },
      -- {
      --   "SmiteshP/nvim-navbuddy",
      --   dependencies = {
      --     "MunifTanjim/nui.nvim",
      --   },
      --   cmd = "Navbuddy",
      --   config = true,
      -- },
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

      require("typescript").setup({
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
        },
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
        "clojure_lsp",
        "elixirls",
        "elmls",
        "fennel_language_server",
        "cl_lsp",
        "ocamllsp", -- opam install ocaml-lsp-server - usually in local switch
        -- "racket_langserver", -- raco pkg install racket-langserver
        "rnix",
        "taplo",
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
      -- local hover = null_ls.builtins.hover

      local sources = {
        actions.gitsigns,
        actions.proselint.with({
          filetypes = { "markdown", "tex" },
          command = "proselint",
          args = { "--json" },
        }),
        actions.refactoring,

        completion.spell,

        diagnostics.yamllint,
        diagnostics.misspell.with({
          filetypes = { "markdown", "text", "txt" },
          args = { "$FILENAME" },
        }),
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

        formatting.elm_format,
        formatting.trim_newlines,
        formatting.trim_whitespace,
      }

      local function add_builtin_if_exists(bin, type)
        if vim.fn.exepath(bin) ~= "" then
          table.insert(sources, null_ls.builtins[type][bin])
        end
      end

      local d = "diagnostics"
      local ca = "code_actions"
      local fmt = "formatting"

      add_builtin_if_exists("eslint_d", d)
      add_builtin_if_exists("eslint_d", ca)
      add_builtin_if_exists("selene", d)
      add_builtin_if_exists("shellcheck", d)

      add_builtin_if_exists("ocamlformat", fmt)
      add_builtin_if_exists("prettierd", fmt)
      add_builtin_if_exists("mdformat", fmt)
      add_builtin_if_exists("rustfmt", fmt)
      add_builtin_if_exists("shfmt", fmt)
      add_builtin_if_exists("stylua", fmt)

      local config = {
        sources = sources,
        fallback_severity = vim.diagnostic.severity.WARN,
        root_dir = lspconfig.util.root_pattern(
          "*.opam",
          ".git",
          ".neoconf.json",
          ".null-ls-root",
          "Makefile",
          "dune-project",
          "esy.json",
          "package.json",
          "tsconfig.json"
        ),
        on_attach = on_attach,
      }

      null_ls.setup(config)
    end,
  },

  {
    enabled = true,
    "simrat39/rust-tools.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
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
    config = function()
      -- check ~/.vscode/extensions/ for correct version
      local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      require("rust-tools").setup({
        server = {
          cmd = { "/Users/p1xelher0/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer" },
          -- cmd = { "/nix/store/bc23kmwxgwlyvpxdnfr92n2kw7j67im8-rust-default-1.68.0-nightly-2022-12-13/bin/rust-analyzer" },
          capabilities = require("internal.lsp").capabilities(),
          -- on_attach = require("internal.lsp").on_attach,
          standalone = false,

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
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      })
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
  },

  {
    "wlangstroth/vim-racket",
    ft = "racket",
  },
}

return M

local M = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      { "hrsh7th/cmp-nvim-lsp" },
      { "jose-elias-alvarez/typescript.nvim" },
      {
        "j-hui/fidget.nvim",
        opts = {
          text = {
            spinner = "triangle",
            done = "✅",
          },
          window = {
            blend = 7,
          },
        },
      },
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
              validate = { enable = true },
            },
          },
        },
      },
    },
    config = function()
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

      nvim_lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = {
          "/Users/p1xelher0/.nix-profile/bin/omnisharp",
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
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
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local lspconfig = require("lspconfig")
      local on_attach = require("internal.lsp").on_attach

      local diagnostics = null_ls.builtins.diagnostics
      -- local hover = null_ls.builtins.hover
      local actions = null_ls.builtins.code_actions

      local sources = {
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,

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
        actions.proselint.with({
          filetypes = { "markdown", "tex" },
          command = "proselint",
          args = { "--json" },
        }),
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
      -- add_builtin_if_exists("selene", d)
      add_builtin_if_exists("shellcheck", d)

      add_builtin_if_exists("ocamlformat", fmt)
      add_builtin_if_exists("prettierd", fmt)
      add_builtin_if_exists("rustfmt", fmt)
      add_builtin_if_exists("shfmt", fmt)
      add_builtin_if_exists("stylua", fmt)

      local config = {
        sources = sources,
        fallback_severity = vim.diagnostic.severity.WARN,
        root_dir = lspconfig.util.root_pattern(
          ".null-ls-root",
          "Makefile",
          ".git",
          "package.json",
          "tsconfig.json",
          "*.opam",
          "dune-project",
          "esy.json"
        ),
        on_attach = on_attach,
      }

      null_ls.setup(config)
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>o", "<Cmd>SymbolsOutline<CR>", desc = "Symbols Outline" },
    },
    config = function()
      local opts = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = "right",
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { "", "" },
        wrap = false,
        keymaps = {
          close = { "q" },
          goto_location = "o",
          focus_location = "O",
          hover_symbol = "K",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "𝓒", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "ℰ", hl = "@type" },
          Interface = { icon = "ﰮ", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "𝓐", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "⊨", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "🔐", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "𝓢", hl = "@type" },
          Event = { icon = "🗲", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "𝙏", hl = "@parameter" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      }

      require("symbols-outline").setup(opts)
    end,
  },
}

return M

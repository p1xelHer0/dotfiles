local enable = false
local langtree = false

local ts_ensure_installed = {
  "lua",
  "nix",
  "vim",
  "ocaml",
  "ocaml_interface",
  "ocamllex",
  "rescript",
  "elm",
  "haskell",
  "elixir",
  "erlang",
  "bash",
  "python",
  "go",
  "rust",
  "c",
  "cpp",
  "llvm",
  "make",
  "c_sharp",
  "javascript",
  "jsdoc",
  "typescript",
  "tsx",
  "svelte",
  "vue",
  "css",
  "scss",
  "json",
  "jsonc",
  "json5",
  "http",
  "graphql",
  "markdown",
  "html",
  "yaml",
  "toml",
  "latex",
  "dockerfile",
  "regex",
}

local treesitter = function()
  local has_ts = pcall(require, "nvim-treesitter.configs")
  if not has_ts then
    vim.notify("Tree-sitter not installed!")
    return
  end
  local lines = vim.fn.line("$")
  if lines > 30000 then
    vim.cmd([[syntax manual]])
    print("skip treesitter")
    return
  end

  if lines > 7000 then
    enable = false
    langtree = false
    vim.cmd([[syntax on]])
  else
    enable = true
    langtree = true
  end

  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = enable,
      additional_vim_regex_highlighting = false,
      use_languagetree = langtree,
    },
  })
end

local treesitter_obj = function()
  local lines = vim.fn.line("$")
  if lines > 30000 then
    print("Large file - skip Tree-sitter")
    return
  end

  require("nvim-treesitter.configs").setup({
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    incremental_selection = {
      enable = enable,
      keymaps = {
        init_selection = "gnn", -- maps in normal mode to init the node/scope selection
        scope_incremental = "gnn", -- increment to the upper scope (as defined in locals.scm)
        node_incremental = "<TAB>", -- increment to the upper named parent
        node_decremental = "<S-TAB>", -- decrement to the previous node
      },
    },
    textobjects = {
      lsp_interop = {
        enable = enable,
        peek_definition_code = { ["DF"] = "@function.outer", ["CF"] = "@class.outer" },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
      },
      select = {
        enable = enable,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = enable,
        swap_next = { ["<leader>a"] = "@parameter.inner" },
        swap_previous = { ["<leader>A"] = "@parameter.inner" },
      },
    },
    ensure_installed = ts_ensure_installed,
    auto_install = true,
  })

  lprint("loading Tree-sitter")
end

local treesitter_ref = function()
  if vim.fn.line("$") > 7000 then
    lprint("skip treesitter")
    enable = false
  end

  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_definitions = { enable = enable },
      highlight_current_scope = { enable = false }, -- prefer black-line
      smart_rename = {
        enable = false, -- prefer lsp rename
        -- keymaps = {
        --   smart_rename = "<Leader>gr", -- mapping to rename reference under cursor
        -- },
      },
      navigation = {
        enable = false, -- use navigator
        -- keymaps = {
        --   goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
        --   list_definitions = "gnD", -- mapping to list all definitions in current file
        --   list_definitions_toc = "gO", -- gT navigator
        --   -- goto_next_usage = "<c->>",
        --   -- goto_previous_usage = "<c-<>",
        -- },
      },
    },
    matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = { "ruby" }, -- optional, list of language that will be disabled
    },
    autopairs = { enable = true },
    autotag = { enable = true },
  })
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.norg = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
    },
  }
end

local textsubjects = function()
  lprint("txt subjects")
  require("nvim-treesitter.configs").setup({
    textsubjects = {
      enable = true,
      prev_selection = ",",
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
  })
end

local treesitter_context = function(width)
  if not packer_plugins["nvim-treesitter"] or packer_plugins["nvim-treesitter"].loaded == false then
    return " "
  end

  local type_patterns = {
    "class",
    "function",
    "method",
    "interface",
    "type_spec",
    "table",
    "if_statement",
    "for_statement",
    "for_in_statement",
    "call_expression",
    "comment",
  }

  if vim.o.ft == "json" then
    type_patterns = { "object", "pair" }
  end

  local f = require("nvim-treesitter").statusline({
    indicator_size = width,
    type_patterns = type_patterns,
  })
  local context = string.format("%s", f)

  if context == "vim.NIL" then
    return " "
  end

  return " " .. context
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("SyntaxFtAuGroup", {}),
  callback = function()
    if vim.tbl_contains(ts_ensure_installed, vim.o.ft) then
      return
    end

    local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f")) or 1
    if fsize < 100000 then
      vim.cmd("syntax on")
    end
  end,
})

return {
  treesitter = treesitter,
  treesitter_obj = treesitter_obj,
  treesitter_ref = treesitter_ref,
  textsubjects = textsubjects,
  context = treesitter_context,
  installed = ts_ensure_installed,
}

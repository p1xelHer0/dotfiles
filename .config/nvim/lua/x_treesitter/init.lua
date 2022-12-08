local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  ensure_installed = {
    "lua",
    "nix",
    "vim",
    "ocaml",
    "ocaml_interface",
    "ocamllex",
    "elm",
    "haskell",
    "elixir",
    "erlang",
    "bash",
    "python",
    "go",
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
    "rust",
    "markdown",
    "html",
    "yaml",
    "toml",
    "latex",
    "dockerfile",
    "regex",
  },
  sync_install = false,
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    javascript = {
      __default = "// %s",
      jsx_element = "{/* %s */}",
      jsx_fragment = "{/* %s */}",
      jsx_attribute = "// %s",
      comment = "// %s",
    },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  playground = { enable = true },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    -- max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}

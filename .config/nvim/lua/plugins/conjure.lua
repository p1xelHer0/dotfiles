return {
  "Olical/conjure",
  ft = require("core.config").get_lisp_ft(),
  dependencies = {
    {
      "PaterJason/cmp-conjure",
      config = function()
        local cmp = require("cmp")
        local config = cmp.get_config()
        table.insert(config.sources, {
          name = "buffer",
          option = {
            sources = {
              { name = "conjure" },
            },
          },
        })
        cmp.setup(config)
      end,
    },
  },
  opts = {},
  config = function(_, opts)
    require("conjure.main").main()
    require("conjure.mapping")["on-filetype"]()
  end,
  init = function()
    vim.g["conjure#debug"] = false
    vim.g["conjure#extract#tree_sitter#enabled"] = true

    vim.g["conjure#mapping#log_split"] = "lx" -- most other plugins use `x`

    --- Common Lisp
    -- vim.g["conjure#client#common_lisp#swank#connection#default_port"] = 50005

    --- Gerbil Scheme
    vim.g["conjure#client#scheme#stdio#command"] = "gxi -:te"
    vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> "
    vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
  end,
}

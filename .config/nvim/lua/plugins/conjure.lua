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
  config = function(_, opts)
    require("conjure.main").main()
    require("conjure.mapping")["on-filetype"]()
  end,
  init = function()
    vim.g["conjure#debug"] = true

    vim.g["conjure#client#scheme#stdio#command"] = "gxi"
    vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> "
    vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
  end,
}

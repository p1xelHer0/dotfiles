local M = {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    lazy = true,
    config = function()
      local lsp = function()
        local msg = ""
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end

      local opts = {
        options = {
          icons_enabled = false,
          section_separators = "",
          component_separators = "",
          theme = "auto",
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = false,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(name, _context)
                return name:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            {
              "filename",
              symbols = {
                modified = "+",
              },
            },
          },
          lualine_c = {
            {
              "diagnostics",
            },
            { "%=" },
            { lsp },
          },
          lualine_x = {
            {
              "o:encoding",
              cond = function()
                return vim.opt.fileencoding:get() ~= "utf-8"
              end,
            },
            {
              "fileformat",
              cond = function()
                return vim.bo.fileformat ~= "unix"
              end,
            },
          },
          lualine_y = {
            {
              "branch",
              fmt = function(name, _context)
                return name
              end,
            },
          },
          lualine_z = {
            {
              "location",
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }

      require("lualine").setup(opts)
    end,
  },
}

return M

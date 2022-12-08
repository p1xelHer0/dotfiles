local config = {}

function config.autopairs()
  local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
  if not has_autopairs then
    print("autopairs not loaded")

    local loader = require("packer").loader
    loader("nvim-autopairs")
    has_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
      print("autopairs not installed")
      return
    end
  end
  require('nvim-autopairs').setup({})
  local status, cmp = pcall(require, 'cmp')
  if not status then
    vim.cmd([[packadd nvim-cmp]])
    cmp = require('cmp')
  end
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

function config.comment()
  require("Comment").setup({
    extended = true,
    pre_hook = function(ctx)
      if vim.bo.filetype == "typescriptreact"
          or vim.bo.filetype == "typescript"
          or vim.bo.filetype == "javascript"
          or vim.bo.filetype == "css"
          or vim.bo.filetype == "html"
          or vim.bo.filetype == "scss"
          or vim.bo.filetype == "svelte"
          or vim.bo.filetype == "uve"
          or vim.bo.filetype == "graphql"
      then
        local U = require("Comment.utils")
        local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = type,
          location = location,
        })
      end
    end,
    post_hook = function(ctx)
      if ctx.range.scol == -1 then
      else
        if ctx.range.ecol > 400 then
          ctx.range.ecol = 1
        end
        if ctx.cmotion > 1 then
          vim.fn.setpos("'<", { 0, ctx.range.srow, ctx.range.scol })
          vim.fn.setpos("'>", { 0, ctx.range.erow, ctx.range.ecol })
          vim.cmd([[exe "norm! gv"]])
        end
      end
    end,
  })
end

function config.neorg()
  local loader = require("packer").loader
  if not packer_plugins["nvim-treesitter"].loaded then
    loader("nvim-treesitter")
  end
  if not packer_plugins["neorg-telescope"].loaded then
    loader("telescope.nvim")
    loader("neorg-telescope")
  end

  require("neorg").setup({
    -- Tell Neorg what modules to load
    load = {
      ["core.defaults"] = {}, -- Load all the default modules
      ["core.norg.concealer"] = {}, -- Allows for use of icons
      ["core.norg.dirman"] = { -- Manage your directories with Neorg
        config = { workspaces = { my_workspace = "~/neorg" } },
      },
      ["core.keybinds"] = { -- Configure core.keybinds
        config = {
          default_keybinds = true, -- Generate the default keybinds
          neorg_leader = "<Leader>o", -- This is the default if unspecified
        },
      },
      ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
    },
  })
  local neorg_callbacks = require("neorg.callbacks")

  neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
      n = { -- Bind keys in normal mode
        { "<C-s>", "core.integrations.telescope.find_linkable" },
      },

      i = { -- Bind in insert mode
        { "<C-l>", "core.integrations.telescope.insert_link" },
      },
    }, { silent = true, noremap = true })
  end)
end

return config

local M = {
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      local status, cmp = pcall(require, "cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
    dependencies = {
      { "hrsh7th/nvim-cmp" },
    },
  },

  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.cmd([[nnoremap <C-s-k> :<c-u>MatchupWhereAmI?<cr>]])
    end,
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      {
        { "nvim-treesitter/nvim-treesitter" },
      },
    },
  },

  {
    "AndrewRadev/switch.vim",
    cmd = { "Switch", "Switch!", "Switch?", "SwitchCase", "SwitchCase!" },
    keys = { "<Plug>(Switch)" },
  },

  {
    "tpope/vim-abolish",
    event = { "CmdlineEnter" },
    keys = { "<Plug>(abolish-coerce-word)" },
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        extended = true,
        pre_hook = function(ctx)
          if
            vim.bo.filetype == "typescriptreact"
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
              -- vim.fn.setpos("'<", { 0, ctx.range.srow, ctx.range.scol })
              -- vim.fn.setpos("'>", { 0, ctx.range.erow, ctx.range.ecol })
              -- vim.cmd([[exe "norm! gv"]])
            end
          end
        end,
      })
    end,
    keys = { "g", "<ESC>", "v", "V", "<C-v>" },
    dependencies = {
      {
        { "nvim-treesitter/nvim-treesitter" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
      },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
  },
}

return M

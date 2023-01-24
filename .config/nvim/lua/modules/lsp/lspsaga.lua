local M = {}

M.setup = function()
  require("lspsaga").setup({
    preview = {
      lines_above = 0,
      lines_below = 10,
    },
    scroll_preview = {
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    request_timeout = 2000,

    finder = {
      edit = { "o", "<CR>" },
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = { "q", "<ESC>" },
    },
    code_action = {
      num_shortcut = true,
      keys = {
        -- string |table type
        quit = "q",
        exec = "<CR>",
      },
    },
    lightbulb = {
      enable = true,
      enable_in_insert = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
    diagnostic = {
      show_code_action = true,
      show_source = true,
      jump_num_shortcut = true,
      keys = {
        exec_action = "o",
        quit = "q",
        go_action = "g",
      },
    },
    rename = {
      quit = "<C-c>",
      exec = "<CR>",
      mark = "x",
      confirm = "<CR>",
      in_select = true,
      whole_project = true,
    },
    outline = {
      win_position = "right",
      win_with = "",
      win_width = 30,
      show_detail = true,
      auto_preview = true,
      auto_refresh = true,
      auto_close = true,
      custom_sort = nil,
      keys = {
        jump = "o",
        expand_collapse = "u",
        quit = "q",
      },
    },
    callhierarchy = {
      show_detail = false,
      keys = {
        edit = "e",
        vsplit = "s",
        split = "i",
        tabe = "t",
        jump = "o",
        quit = "q",
        expand_collapse = "u",
      },
    },
    symbol_in_winbar = {
      enable = true,
      separator = " ",
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      respect_root = false,
      color_mode = true,
    },
    ui = {
      -- currently only round theme
      theme = "round",
      -- this option only work in neovim 0.9
      title = true,
      -- border type can be single,double,rounded,solid,shadow.
      border = "solid",
      winblend = 0,
      expand = "",
      collapse = "",
      preview = " ",
      code_action = "💡",
      diagnostic = "🐞",
      incoming = " ",
      outgoing = " ",
      colors = {
        --float window normal background color
        normal_bg = "#1d1536",
        --title background color
        title_bg = "#afd700",
        red = "#e95678",
        magenta = "#b33076",
        orange = "#FF8700",
        yellow = "#f7bb3b",
        green = "#afd700",
        cyan = "#36d0e0",
        blue = "#61afef",
        purple = "#CBA6F7",
        white = "#d1d4cf",
        black = "#1c1c19",
      },
      -- kind = signs.kind_icons,
    },
    -- diagnostic_header = severity_signs,
    -- finder_icons = {
    --   def = signs.lspsaga.def,
    --   ref = signs.lspsaga.ref,
    --   link = signs.lspsaga.link,
    -- },
    -- show_outline = {
    --   virt_text = signs.lspsaga.indent,
    -- },
  })
end

return M

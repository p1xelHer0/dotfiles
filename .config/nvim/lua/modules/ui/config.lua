local config = {}
packer_plugins = packer_plugins or {} -- supress warning

-- colorscheme here
function config.auto_dark_mode()
  local dark_colorscheme = 'tokyonight-storm'
  local light_colorscheme = 'tokyonight-day'
  local auto_dark_mode = require 'auto-dark-mode'
  auto_dark_mode.setup {
    set_dark_mode = function()
      vim.api.nvim_set_option('background', 'dark')
      vim.cmd.colorscheme(dark_colorscheme)
    end,
    set_light_mode = function()
      vim.api.nvim_set_option('background', 'light')
      vim.cmd.colorscheme(light_colorscheme)
    end,
  }
  auto_dark_mode.init()
end

function config.windline()
  if not packer_plugins['nvim-web-devicons'].loaded then
    packer_plugins['nvim-web-devicons'].loaded = true
    require('packer').loader 'nvim-web-devicons'
  end
end

function config.notify()
  require('notify').setup {}
  require('telescope').load_extension 'notify'
end

function config.noice()
  require('noice').setup {
    cmdline = {
      enabled = false,
    },
    messages = {
      enabled = false,
    },
    lsp_progress = {
      enabled = true,
      format = 'lsp_progress',
      format_done = 'lsp_progress_done',
      throttle = 1000 / 30,
      view = 'mini',
    },
  }
end

function config.nvim_tree_setup()
  vim.cmd [[autocmd Filetype NvimTree set cursorline]]
end

function config.nvim_tree()
  require('nvim-tree').setup {
    sync_root_with_cwd = false,
    git = { ignore = false },
    renderer = {
      icons = {
        glyphs = {
          default = '',
          symlink = '',
          folder = {
            arrow_closed = '',
            arrow_open = '',
            default = '/',
            open = '—',
            empty = '\\',
            empty_open = '-',
            symlink = '>',
            symlink_open = 'v',
          },
          git = {
            deleted = '-',
            renamed = '"',
            staged = '^',
            unmerged = '=',
            unstaged = '~',
            untracked = '+',
            ignored = '',
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
  }
end

function config.scrollbar()
  if vim.wo.diff then
    return
  end
  local w = vim.api.nvim_call_function('winwidth', { 0 })
  if w < 70 then
    return
  end
  local vimcmd = vim.api.nvim_command
  vimcmd('augroup ' .. 'ScrollbarInit')
  vimcmd 'autocmd!'
  vimcmd "autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()"
  vimcmd "autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()"
  vimcmd "autocmd WinLeave,FocusLost,BufLeave    * silent! lua require('scrollbar').clear()"
  vimcmd 'autocmd WinLeave,BufLeave    * silent! DiffviewClose'
  vimcmd 'augroup end'
  vimcmd 'highlight link Scrollbar Comment'
  vim.g.sb_default_behavior = 'never'
  vim.g.sb_bar_style = 'solid'
end

function config.tokyonight()
  vim.g.tokyonight_style = 'moon'
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }
  vim.g.tokyonight_transparent = true
end

function config.blankline()
  vim.opt.termguicolors = true
  vim.cmd [[highlight default IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
  vim.cmd [[highlight default IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
  vim.cmd [[highlight default IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
  vim.cmd [[highlight default IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
  vim.cmd [[highlight default IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
  vim.cmd [[highlight default IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
  -- vim.opt.list = true
  require('indent_blankline').setup {
    enabled = true,
    char = "",
    -- char_list = { '', '┊', '┆', '¦', '|', '¦', '┆', '┊', '' },
    filetype_exclude = {
      'help',
      'startify',
      'dashboard',
      'packer',
      'guihua',
      'NvimTree',
      'sidekick',
    },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    buftype_exclude = { 'terminal' },
    space_char_blankline = ' ',
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6',
    },
    context_patterns = {
      'class',
      'return',
      'function',
      'method',
      '^if',
      'if',
      '^while',
      'jsx_element',
      '^for',
      'for',
      '^object',
      '^table',
      'block',
      'arguments',
      'if_statement',
      'else_clause',
      'jsx_element',
      'jsx_self_closing_element',
      'try_statement',
      'catch_clause',
      'import_statement',
      'operation_type',
    },
    bufname_exclude = { 'README.md' },
  }
end

function config.wilder()
  local wilder = require 'wilder'
  wilder.setup { modes = { ':', '/', '?' } }
  local gradient = {
    '#f4468f',
    '#fd4a85',
    '#ff507a',
    '#ff566f',
    '#ff5e63',
    '#ff6658',
    '#ff704e',
    '#ff7a45',
    '#ff843d',
    '#ff9036',
    '#f89b31',
    '#efa72f',
    '#e6b32e',
    '#dcbe30',
    '#d2c934',
    '#c8d43a',
    '#bfde43',
    '#b6e84e',
    '#aff05b',
  }

  for i, fg in ipairs(gradient) do
    gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
  end

  wilder.set_option('pipeline', {
    wilder.branch(
      wilder.cmdline_pipeline {
        language = 'python',
        fuzzy = 2,
      },
      wilder.python_file_finder_pipeline {
        -- to use ripgrep : {'rg', '--files'}
        -- to use fd      : {'fd', '-tf'}
        file_command = { 'rg', '--files' }, --  { "find", ".", "-type", "f", "-printf", "%P\n" },
        -- to use fd      : {'fd', '-td'}
        dir_command = { 'fd', '-tf' }, -- { "find", ".", "-type", "d", "-printf", "%P\n" },
        -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
        -- found at https://github.com/nixprime/cpsm
        filters = { 'fuzzy_filter', 'difflib_sorter' },
      },
      --
      wilder.python_search_pipeline {
        pattern = wilder.python_fuzzy_pattern(), --python_fuzzy_delimiter_pattern()
        sorter = wilder.python_difflib_sorter(),
        engine = 're',
      }
    ),
  })
  local highlighters = {
    wilder.highlighter_with_gradient {
      wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
    },
    wilder.basic_highlighter(),
  }
  wilder.set_option(
    'renderer',
    wilder.renderer_mux {
      [':'] = wilder.popupmenu_renderer {
        highlights = { gradient = gradient },
        min_height = '5%',
        max_height = '35%',
        highlighter = highlighters,
      },
      ['/'] = wilder.wildmenu_renderer {
        highlighter = highlighters,
      },
    }
  )
end

return config

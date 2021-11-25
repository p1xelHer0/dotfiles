require "plugins"
require "treesitter"
require "lsp"

local parsers = require "nvim-treesitter.parsers"

local add_option = function(option_type, options)
  if type(options) ~= "table" then
    error 'options should be a type of "table"'
    return
  end
  local vim_option = vim[option_type]
  for key, value in pairs(options) do
    vim_option[key] = value
  end
end

local option = {}

option.g = function(options)
  add_option("o", options)
end

option.w = function(options)
  add_option("wo", options)
end

option.b = function(options)
  add_option("bo", options)
end

vim.g.mapleader = " "

option.g {
  clipboard = "unnamedplus",
  scrolloff = 5,
  ignorecase = true,
  smartcase = true,
  showmatch = true,
  timeoutlen = 500,
  ttimeoutlen = 100,
  updatetime = 250,
  redrawtime = 250,
  list = true,
  listchars = "tab:→ ,trail:·,nbsp:×",
  linebreak = true,
  fillchars = vim.o.fillchars .. "vert: ",
  undofile = true,
  completeopt = "menu,menuone,noinsert,noselect",
  formatoptions = "jtcroql",
  inccommand = "nosplit",
  shortmess = "atIcF",
  visualbell = true,
  ruler = true,
}

option.w {
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  foldlevel = 99,
  foldmethod = "syntax",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldtext = "v:lua.foldText()",
  linebreak = true,
  breakindent = true,
}

option.b {
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  shiftwidth = 2,
  copyindent = true,
  swapfile = false,
  backupcopy = "yes",
  indentexpr = "nvim_treesitter#indent()",
}

vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

vim.api.nvim_set_keymap("", "Q", "<NOP>", {})
vim.api.nvim_set_keymap("", "<Up>", "<NOP>", {})
vim.api.nvim_set_keymap("", "<Down>", "<NOP>", {})
vim.api.nvim_set_keymap("", "<Left>", "<NOP>", {})
vim.api.nvim_set_keymap("", "<Right>", "<NOP>", {})
vim.api.nvim_set_keymap("i", "<Up>", "<NOP>", {})
vim.api.nvim_set_keymap("i", "<Down>", "<NOP>", {})
vim.api.nvim_set_keymap("i", "<Left>", "<NOP>", {})
vim.api.nvim_set_keymap("i", "<Right>", "<NOP>", {})

vim.api.nvim_set_keymap("n", "Y", "0y$", { noremap = true })

vim.api.nvim_set_keymap(
  "n",
  "<Leader>/",
  ":nohl<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader><Leader>r",
  ":so $HOME/Dev/Repo/Private/ttwnty.vim/colors/ttwnty.vim<CR>:so $HOME/dotfiles/conf/nvim/.vimrc<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader><Leader>f",
  ":Neoformat<CR>:w<CR>",
  { noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap(
--     "n",
--     "<C-p>",
--     [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]],
--     {noremap = true, silent = true}
-- )

vim.api.nvim_set_keymap(
  "n",
  "<C-p>",
  [[<Cmd>lua require('telescope.builtin').find_files()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>f",
  [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],
  { noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap(
--     "n",
--     "<Leader>fg",
--     [[<Cmd>lua require('telescope.builtin').git_files()<CR>]],
--     {noremap = true, silent = true}
-- )

vim.api.nvim_set_keymap(
  "n",
  "<Leader>b",
  [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "ga",
  "<Plug>(EasyAlign)",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "x",
  "ga",
  "<Plug>(EasyAlign)",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>n",
  ":NvimTreeToggle<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>N",
  ":NvimTreeFindFileToggle<CR>",
  { noremap = true, silent = true }
)

vim.opt.runtimepath:append "/usr/local/opt/fzf"
vim.opt.runtimepath:append "<SHARE_DIR>/merlin/vim"

vim.g.limelight_conceal_ctermfg = 17
vim.g.limelight_priority = -1

vim.g.nvim_tree_icons = {
  git = {
    deleted = "-",
    renamed = "=",
    staged = "^",
    unmerged = '"',
    unstaged = "~",
    untracked = "+",
  },
  folder = {
    arrow_closed = "",
    arrow_open = "",
    default = "/",
    open = "—",
    empty = "\\",
    empty_open = "-",
    symlink = ">",
    symlink_open = "v",
  },
}

local configs = parsers.get_parser_configs()
local ft_str = table.concat(
  vim.tbl_map(function(ft)
    return configs[ft].filetype or ft
  end, parsers.available_parsers()),
  ","
)

vim.cmd(
  "autocmd Filetype "
    .. ft_str
    .. " setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()"
)

return option

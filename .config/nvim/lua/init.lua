vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 100
vim.opt.updatetime = 250
vim.opt.redrawtime = 250
vim.opt.list = true
vim.opt.listchars = "tab:→ ,trail:·,nbsp:×"
vim.opt.linebreak = true
vim.opt.fillchars = vim.o.fillchars .. "vert: "
vim.opt.undofile = true
vim.opt.completeopt = "menu,menuone,noinsert,noselect"
vim.opt.formatoptions = "jtcroql"
vim.opt.inccommand = "nosplit"
vim.opt.shortmess = "atIcF"
vim.opt.visualbell = true
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.foldlevel = 99
vim.opt.foldmethod = "syntax"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "v:lua.foldText()"
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.copyindent = true
vim.opt.swapfile = false
vim.opt.backupcopy = "yes"
vim.opt.indentexpr = "nvim_treesitter#indent()"

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

vim.api.nvim_set_keymap("n", "Y", "0Y", { noremap = true })

-- function _G.smart_yank(k)
--   return 'my"' .. vim.api.nvim_eval "v:register" .. k .. "`y"
-- end
--
-- vim.api.nvim_set_keymap(
--   "v",
--   "y",
--   'v:lua.smart_yank("y")',
--   { expr = true, noremap = true }
-- )
--
-- vim.api.nvim_set_keymap(
--   "v",
--   "y",
--   'v:lua.smart_yank("Y")',
--   { expr = true, noremap = true }
-- )

vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })

vim.api.nvim_set_keymap(
  "n",
  "<Leader>/",
  ":nohl<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader><Leader>r",
  ":so $HOME/code/github/p1xelHer0/ttwnty.vim/colors/ttwnty.vim<CR>:so $HOME/dotfiles/conf/nvim/init.vim<CR>",
  { noremap = true }
)

-- Telescope
vim.api.nvim_set_keymap(
  "n",
  "<Leader><Leader>t",
  ":Telescope<CR>",
  { noremap = true, silent = true }
)

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

vim.api.nvim_set_keymap(
  "n",
  "<Leader>p",
  [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>b",
  [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
  { noremap = true, silent = true }
)

-- Telescope LSP
vim.api.nvim_set_keymap(
  "n",
  "<Leader>lr",
  [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>ls",
  [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>ld",
  [[<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>lt",
  [[<Cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>lc",
  [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "x",
  "<Leader>lc",
  [[<Cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { silent = true })
vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { silent = true })

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

vim.api.nvim_set_keymap(
  "n",
  "<Leader>mp",
  ":MarkdownPreview<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>zm",
  ":ZenMode<CR>",
  { noremap = true, silent = true }
)

vim.opt.runtimepath:append "/usr/local/opt/fzf"
vim.opt.runtimepath:append "<SHARE_DIR>/merlin/vim"

vim.g.ditto_dir = "$HOME/dotfiles/conf/ditto"

vim.g.nvim_tree_icons = {
  git = {
    deleted = "-",
    renamed = '"',
    staged = "^",
    unmerged = "=",
    unstaged = "~",
    untracked = "+",
    ignored = "",
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

local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")

if parsers_ok then
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
end

require "plugins"
require "treesitter"
require "lsp"

vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

vim.keymap.set("n", "<Leader>/", ":nohl<CR>", { noremap = true, silent = true })

vim.keymap.set(
  "n",
  "<Leader><Leader>r",
  ":so $HOME/code/github/p1xelHer0/ttwnty.vim/colors/ttwnty.vim<CR>:so $HOME/dotfiles/.config/nvim/init.vim<CR>",
  { noremap = true }
)

vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { silent = true })
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { silent = true })

vim.keymap.set(
  "n",
  "<Leader>n",
  ":NvimTreeToggle<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<Leader>N",
  ":NvimTreeFindFileToggle<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<Leader>mp",
  ":MarkdownPreview<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<Leader>zm",
  ":ZenMode<CR>",
  { noremap = true, silent = true }
)

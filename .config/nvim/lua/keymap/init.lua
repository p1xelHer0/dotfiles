local k = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
k("n", " ", "", { noremap = true })
k("n", "\\", "", { noremap = true })
k("x", " ", "", { noremap = true })
k("x", "\\", "", { noremap = true })

vim.g.mapleader = " "
vim.g.localleader = "\\"

-- Normal mode
k("n", "<Leader>w", ":w<CR>", opts)
k("n", "<Leader>W", ":w!<CR>", opts)
k("n", "<Leader>q", ":q<CR>", opts)
k("n", "<Leader>Q", ":q!<CR>", opts)
k("n", "<Leader>x", ":x<CR>", opts)
k("n", "<Leader>X", ":x!<CR>", opts)
k("n", "<Leader>e", ":e<CR>", opts)

k("n", "<Leader>k", function()
  vim.cmd([[set number!]])
  vim.cmd([[set relativenumber!]])

  if vim.opt.signcolumn == "yes" then
    vim.opt.signcolumn = "no"
  else
    vim.opt.signcolumn = "yes"
  end
end, opts)

k("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
k("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

k("n", "<Leader>/", "<Cmd>noh<CR>", opts)

k("n", "<Leader>L", function()
  require("lazy").home()
end, opts)

k("n", "<Leader>0", ":Inspect<CR>", opts)

local k = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
k("n", " ", "", { noremap = true })
k("x", " ", "", { noremap = true })

-- Normal mode
k("n", "<Leader>w", ":w<CR>", opts)
k("n", "<Leader>W", ":w!<CR>", opts)
k("n", "<Leader>q", ":q<CR>", opts)
k("n", "<Leader>Q", ":q!<CR>", opts)
k("n", "<Leader>x", ":x<CR>", opts)
k("n", "<Leader>X", ":x!<CR>", opts)
k("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
k("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
k("n", "<Leader>/", ":nohl<CR>", opts)
k("n", "<Leader>L", function()
  require("lazy").home()
end, opts)

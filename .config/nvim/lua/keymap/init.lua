local k = vim.keymap.set

-- Normal mode
k("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })
k("n", "<Leader>W", ":w!<CR>", { noremap = true, silent = true })
k("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true })
k("n", "<Leader>Q", ":q!<CR>", { noremap = true, silent = true })
k("n", "<Leader>x", ":x<CR>", { noremap = true, silent = true })
k("n", "<Leader>X", ":x!<CR>", { noremap = true, silent = true })
k("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
k("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
k("n", "<Leader>/", ":nohl<CR>", { noremap = true, silent = true })

k("n", "<Leader><Leader>i", "<Cmd>IndentBlanklineToggle<CR>", { silent = true, noremap = true })

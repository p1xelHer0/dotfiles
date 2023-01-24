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

-- Insert mode

-- packer.nvim
k("n", "<Leader>pC", "<Cmd>PackerClean<CR>", { noremap = true })
k("n", "<Leader>pc", "<Cmd>PackerCompile<CR>", { noremap = true })
k("n", "<Leader>pi", "<Cmd>PackerInstall<CR>", { noremap = true })
k("n", "<Leader>ps", "<Cmd>PackerSync<CR>", { noremap = true })
k("n", "<Leader>pu", "<Cmd>PackerUpdate<CR>", { noremap = true })

-- nvim-tree.lua
k("n", "<Leader>n", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
k("n", "<Leader>N", "<Cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true })

-- Telescope
k("n", "<C-p>", "<Cmd>Telescope find_files<CR>", { silent = true, noremap = true })
k("n", "<Leader>f", "<Cmd>Telescope live_grep<CR>", { silent = true })
k("n", "<Leader>b", "<Cmd>Telescope buffers<CR>", { silent = true, noremap = true })
k("n", "<Leader>T", "<Cmd>Telescope<CR>", { silent = true, noremap = true })

k("n", "<Leader><Leader>i", "<Cmd>IndentBlanklineToggle<CR>", { silent = true, noremap = true })

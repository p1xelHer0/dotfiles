-- use `vim.cmd` instead of `vim.bo` because it is yet more reliable
vim.cmd("setlocal spell")
vim.cmd("setlocal wrap")
vim.cmd("setlocal foldmethod=expr foldexpr=v:lua.vim.treesitter.foldexpr()")

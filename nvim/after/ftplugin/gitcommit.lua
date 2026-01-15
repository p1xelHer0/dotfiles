-- use `vim.cmd` instead of `vim.bo` because it is yet more reliable
vim.cmd("setlocal spell")
vim.cmd("setlocal wrap")
vim.cmd("setlocal textwidth=72")
vim.cmd("setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=1")

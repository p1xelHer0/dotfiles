-- INFO: settings to set nushell as the shell for the :! command
-- path to the Nushell executable
vim.opt.shell = "nu"

-- WARN: disable the usage of temp files for shell commands
-- because Nu doesn't support `input redirection` which Neovim uses to send buffer content to a command:
--      `{shell_command} < {temp_file_with_selected_buffer_content}`
-- When set to `false` the stdin pipe will be used instead.
-- NOTE: some info about `shelltemp`: https://github.com/neovim/neovim/issues/1008
vim.opt.shelltemp = false

-- string to be used to put the output of shell commands in a temp file
-- 1. when 'shelltemp' is `true`
-- 2. in the `diff-mode` (`nvim -d file1 file2`) when `diffopt` is set
--    to use an external diff command: `set diffopt-=internal`
vim.opt.shellredir = "out+err> %s"

-- flags for nu:
-- * `--stdin`       redirect all input to -c
-- * `--no-newline`  do not append `\n` to stdout
-- * `--commands -c` execute a command
vim.opt.shellcmdflag = "--stdin --no-newline -c"

-- disable all escaping and quoting
vim.opt.shellxescape = ""
vim.opt.shellxquote = ""
vim.opt.shellquote = ""

-- string to be used with `:make` command to:
-- 1. save the stderr of `makeprg` in the temp file which Neovim reads using `errorformat` to populate the `quickfix` buffer
-- 2. show the stdout, stderr and the return_code on the screen
-- NOTE: `ansi strip` removes all ansi coloring from nushell errors
vim.opt.shellpipe =
  "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
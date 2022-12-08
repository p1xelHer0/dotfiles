local k = vim.keymap.set

local keymap = {}

function keymap.telescope()
  k('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
  k('n', '<Leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  k('n', '<Leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
  k('n', '<Leader>F', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
  k('n', '<Leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
end

return keymap

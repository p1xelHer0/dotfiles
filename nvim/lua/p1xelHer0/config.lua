local M = {}

function M.dotfiles_path() return os.getenv("HOME") .. "/dotfiles" end
function M.lazy_path() return vim.fn.stdpath("data") .. "/lazy/lazy.nvim" end
function M.lazy_repo() return "https://github.com/folke/lazy.nvim.git" end
function M.lazy_file_event() return { "BufReadPost", "BufNewFile", "BufWritePre" } end

function M.options()
  return {
    scrolloff = 5,
    blend = 0,
    bigfile_size = 1024 * 100 * 1.5,
  }
end

return M

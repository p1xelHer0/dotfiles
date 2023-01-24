local config = {}

function config.telescope_preload()
  if not packer_plugins["plenary.nvim"].loaded then
    require("packer").loader("plenary.nvim")
  end
end

function config.telescope()
  require("modules.tools.telescope").setup()
end

function config.project()
  local data_path = require("core.helper").get_data_path()
  require("project_nvim").setup({
    manual_mode = true,
    datapath = data_path,
    ignore_lsp = { "efm" },
    exclude_dirs = { "~/.cargo/*" },
    silent_chdir = true,
  })
  require("modules.tools.telescope")
  require("telescope").load_extension("projects")
end

function config.neogit()
  local loader = require("packer").loader
  loader("diffview.nvim")
  local signs = require("core.helper").get_icons()
  require("neogit").setup({
    auto_refresh = false,
    signs = {
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
    },
  })
end

function config.diffview()
  local cb = require("diffview.config").diffview_callback
  local signs = require("core.helper").get_icons()
  require("diffview").setup({
    diff_binaries = false, -- Show diffs for binaries
    use_icons = false, -- Requires nvim-web-devicons
    enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
    signs = { fold_closed = "", fold_open = "" },
    file_panel = {
      win_config = {
        position = "left", -- One of 'left', 'right', 'top', 'bottom'
        width = 35, -- Only applies when position is 'left' or 'right'
      },
    },
    key_bindings = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      view = {
        ["<Tab>"] = cb("select_next_entry"), -- Open the diff for the next file
        ["<S-Tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
        ["<Leader>e"] = cb("focus_files"), -- Bring focus to the files panel
        ["<Leader>b"] = cb("toggle_files"), -- Toggle the files panel.
      },
      file_panel = {
        ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
        ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
        ["o"] = cb("select_entry"),
        ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
        ["<Tab>"] = cb("select_next_entry"),
        ["<S-Sab>"] = cb("select_prev_entry"),
        ["<Leader>e"] = cb("focus_files"),
        ["<Leader>b"] = cb("toggle_files"),
      },
    },
  })
end

function config.gitsigns()
  if not packer_plugins["plenary.nvim"].loaded then
    require("packer").loader("plenary.nvim")
  end
  local signs = require("core.helper").get_icons()
  require("gitsigns").setup({
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = "+",
        numhl = "GitSignsAddNr",
        -- linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = "~",
        numhl = "GitSignsChangeNr",
        -- linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "_",
        numhl = "GitSignsDeleteNr",
        -- linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "‾",
        numhl = "GitSignsDeleteNr",
        -- linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "~",
        numhl = "GitSignsChangeNr",
        -- linehl = "GitSignsChangeLn",
      },
      untracked = {
        hl = "GitSignsAdd",
        text = "~",
        numhl = "GitSignsAddNr",
        -- linehl = "GitSignsAddLn",
      },
    },
    update_debounce = 400,
    numhl = false,
    word_diff = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
      -- map("n", "<leader>hS", gs.stage_buffer) -- hydra
      -- map("n", "<leader>hu", gs.undo_stage_hunk)
      -- map("n", "<leader>hR", gs.reset_buffer)
      -- map("n", "<leader>hp", gs.preview_hunk)
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>tb", gs.toggle_current_line_blame)
      map("n", "<leader>hd", gs.diffthis)
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end)
      -- map("n", "<leader>td", gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,

    watch_gitdir = { interval = 1000, follow_files = true },
    status_formatter = nil, -- Use default
    debug_mode = false,
    current_line_blame = true,
    current_line_blame_opts = { delay = 1500 },
    diff_opts = { internal = true },
  })

  -- vim.api.nvim_set_hl(0, "GitSignsAddInline", { link = "DiffAdd" }) -- diff mode: Deleted line |diff.txt|
  -- vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { link = "DiffDelete" }) -- diff mode: Deleted line |diff.txt|
  -- vim.api.nvim_set_hl(0, "GitSignsChangeInline", { link = "DiffAdd" }) -- diff mode: Deleted line |diff.txt|
  -- vim.api.nvim_create_user_command("Stage", "'<,'>Gitsigns stage_hunk", { range = true })
end

return config

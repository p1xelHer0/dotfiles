local C = require("p1xelHer0.config")
local dotfiles_path = C.dotfiles_path()

local function input_sync(opts)
  local co = coroutine.running()
  vim.ui.input(opts, function(result)
    vim.schedule(function() coroutine.resume(co, result) end)
  end)
  return coroutine.yield()
end

local function select_sync(list, opts)
  local co = coroutine.running()
  vim.ui.select(list, opts, function(result)
    vim.schedule(function() coroutine.resume(co, result) end)
  end)
  return coroutine.yield()
end

local function pick_program()
  local dap = require("dap")

  local result = input_sync({
    prompt = "Path to executable (compiled with -debug!): ",
    default = vim.fn.getcwd() .. "/",
    completion = "file",
  })

  if result == nil or result == "" or result:sub(-1) == "/" then return dap.ABORT end

  return result
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>bo", function() require("dapui").toggle() end },
      { "<leader>bc", ":DapContinue<CR>" },
      { "<leader>bb", ":DapToggleBreakpoint<CR>" },
      { "<leader>bB", function() require("dap").toggle_breakpoint(vim.fn.input("[DAP] Condition > ")) end },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local daputil = require("dap.utils")

      require("nvim-dap-virtual-text").setup({})

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        vim.keymap.set("n", "<Right>", dap.step_over)
        vim.keymap.set("n", "<Up>", dap.step_out)
        vim.keymap.set("n", "<Down>", dap.step_into)
        dapui.open({})
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        pcall(vim.keymap.del, "n", "<Right>")
        pcall(vim.keymap.del, "n", "<Up>")
        pcall(vim.keymap.del, "n", "<Down>")
        dapui.close({})
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        pcall(vim.keymap.del, "n", "<Right>")
        pcall(vim.keymap.del, "n", "<Up>")
        pcall(vim.keymap.del, "n", "<Down>")
        dapui.close({})
      end

      local sign = vim.fn.sign_define
      -- stylua: ignore start
      sign("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",          linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint",            { text = "◆", texthl = "DapLogPoint",            linehl = "", numhl = "" })
      -- stylua: ignore end

      local codelldb = {
        type = "server",
        port = 1300,
        executable = {
          command = "codelldb",
          args = { "--port", "1300" },
        },
      }

      dap.adapters.codelldb = codelldb
      local lldb_init_cmd = "command source " .. dotfiles_path .. "/lldb/.lldbinit"

      local lldb_default_config = {
        {
          name = "Launch & Debug",
          type = "codelldb",
          request = "launch",
          cwd = vim.fn.getcwd(),
          stopOnEntry = false,
          program = pick_program,
          args = function()
            local result = input_sync({
              prompt = "program arguments: ",
            })
            if result == nil then return dap.ABORT end
            return vim.split(result, " ")
          end,
          initCommands = { lldb_init_cmd },
        },
        {
          name = "Attach & Debug",
          type = "codelldb",
          request = "attach",
          stopOnEntry = false,
          program = pick_program,
          pid = daputil.pick_process,
          initCommands = { lldb_init_cmd },
        },
      }

      dap.configurations.c = lldb_default_config
      dap.configurations.cpp = lldb_default_config
      dap.configurations.objc = lldb_default_config
      dap.configurations.objcpp = lldb_default_config
      dap.configurations.odin = lldb_default_config
      dap.configurations.zig = lldb_default_config

      local lazy_load_ft = {
        go = {
          configured = false,
          config = function() require("gopher.dap").setup() end,
        },
      }

      local on_ft = function(ft)
        local curr_ft = lazy_load_ft[ft]
        if curr_ft and not curr_ft.configured then
          vim.schedule_wrap(
            function() vim.notify("Lazy loading " .. ft .. " DAP configuration", vim.log.levels.INFO) end
          )
          curr_ft.config()
          curr_ft.configured = true
        end
      end
      on_ft(vim.bo.filetype)

      local ft_pattern = {}
      for k, _ in pairs(lazy_load_ft) do
        table.insert(ft_pattern, k)
      end
      local dap_plugin_group = vim.api.nvim_create_augroup("plugins.dap", {})
      local autocmd = function(event, pattern, callback, desc)
        vim.api.nvim_create_autocmd(event, {
          group = dap_plugin_group,
          pattern = pattern,
          callback = callback,
          desc = "DAP: " .. desc,
        })
      end

      autocmd("FileType", ft_pattern, function(data) on_ft(data.match) end, "Lazy load DAP config for ft")
    end,
  },
}

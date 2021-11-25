local nvim_lsp = require "lspconfig"

local configs = require "lspconfig/configs"
local util = require "lspconfig/util"

local server_name = "rescript"

configs[server_name] = {
  default_config = {
    filetypes = { "rescript" },
    root_dir = function(fname)
      return util.root_pattern "bsconfig.json"(fname)
    end,
  },
  docs = {
    package_json = "https://raw.githubusercontent.com/rescript-lang/vim-rescript/master/rescript-vscode/extension/server/package.json",
    description = [[
https://github.com/rescript-lang/rescript-vscode

ReScript language server.

The ReScript language server is an implementation detail of the `rescript-vscode` extension called `rescript-editor-support.exe`.

`rescript-vscode` comes bundeled in the `https://github.com/rescript-lang/vim-rescript` plugin. This is the recommended way of installing it and the `rescript-editor-support.exe`.

However, it can also be installed by following the instructions [here](https://github.com/rescript-lang/rescript-vscode/#use-with-other-editors).

The gist here is finding the absolute path to the `rescript-editor-server.exe` for your platform.

```lua
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "darwin"
elseif vim.fn.has("unix") == 1 then
  system_name = "linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "win32"
else
  print("Unsupported system for rescript-editor-support")
end

-- set the path to the `rescript-vscode` installation
-- example using [vim-plug](https://github.com/junegunn/vim-plug): `/Users/yourname/.config/nvim/plugged/vim-rescript/rescript-vscode`
local rescript_vscode_root_path = "/Users/youruser/.config/nvim/plugged/vim-rescript/rescript-vscode"

-- example of full path to Linux binary installed with `vim-plug`: `/Users/pontusnagy/.config/nvim/plugged/vim-rescript/rescript-vscode/extension/server/linux/rescript-editor-support.exe`
local rescript_server_binary = rescript_vscode_root_path .."/extension/server/" .. system_name.."/rescript-editor-support.exe"

require'lspconfig'.rescript.setup {
  cmd = {rescript_server_binary, "--node-ipc"},
}

-- tl;dr
require'lspconfig'.rescript.setup {
  cmd = {
    "/absolute/path/to/rescript-vscode/extension/server/yourplatform/rescript-editor-support.exe",
    "--node-ipc"
  },
}
```
]],
  },
}

local capabilities = require "lsp.settings.capabilities"
local on_attach = require "lsp.settings.on_attach"

local rescript_server_binary =
  "/Users/pontusnagy/.config/nvim/plugged/vim-rescript/rescript-vscode/extension/server/darwin/rescript-editor-support.exe"

nvim_lsp.rescript.setup {
  cmd = {
    rescript_server_binary,
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

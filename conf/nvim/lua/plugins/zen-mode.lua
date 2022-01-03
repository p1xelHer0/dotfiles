local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
  return
end

zen_mode.setup {
  plugins = {
    tmux = {
      enabled = true,
    },
    gitsigns = {
      enabled = false,
    },
  },
}

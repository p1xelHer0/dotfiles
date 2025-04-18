local M = {}

---Returns hex color of the value of the highlight group `hl_name`
---@param hl_name string highlight group
---@param value? string foreground/background
---@return string | nil hex value
M.get_highlight = function(hl_name, value)
  if value == "fg" then
    value = "foreground"
  elseif value == "bg" then
    value = "background"
  end
  value = value or "foreground"

  local hl = vim.api.nvim_get_hl_by_name(hl_name, true)

  if not hl[value] then
    return nil
  end

  local color = string.format("#%06x", hl[value])

  return color
end

return M

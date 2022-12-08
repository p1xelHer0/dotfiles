local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

local function prequire(name)
  local module_found, res = pcall(require, name)
  return module_found and res or nil
end

local is_prior_char_whitespace = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

local function termcodes(code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end

local t = termcodes

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
    -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
    --   return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  elseif prequire('luasnip') and require('luasnip').expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  elseif prequire('cmp') and require('cmp').visible() then
    return require('cmp').mapping.select_next_item()
  end
  return t "<Tab>"
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif prequire('luasnip') and prequire('luasnip').jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  elseif prequire('cmp') and require('cmp').visible() then
    return require('cmp').mapping.select_prev_item()
  end
  return t "<S-Tab>"
end

_G.word_motion_move = function(key)
  if not packer_plugins['vim-wordmotion'] or not packer_plugins['vim-wordmotion'].loaded then
    require 'packer'.loader("vim-wordmotion")
    -- vim.cmd [[packadd vim-wordmotion]]
  end
  local map = key == 'w' and '<Plug>(WordMotion_w)' or '<Plug>(WordMotion_b)'
  return t(map)
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.smart_tab = function()
  local cmp = require('cmp')
  local ok, luasnip = pcall(require, 'luasnip')
  local luasnip_status = false
  if ok then
    luasnip_status = luasnip.expand_or_jumpable()
  end

  if cmp.visible() and not luasnip_status then
    return '<C-n>'
  elseif luasnip_status then
    return '<Plug>luasnip-expand-or-jump'
  elseif has_words_before() then
    return '<Tab>'
  else
    return '<Tab>'
  end
end

_G.smart_shift_tab = function()
  local cmp = require('cmp')
  local _, luasnip = pcall(require, 'luasnip')

  if cmp.visible() then
    return '<C-p>'
  elseif luasnip.jumpable(-1) then
    return "<cmd>lua require'luasnip'.jump(-1)<CR>"
  else
    return '<S-Tab>'
  end
end

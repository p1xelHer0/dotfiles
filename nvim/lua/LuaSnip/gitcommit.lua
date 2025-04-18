local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local chore = "chore"
local feature = "feat"
local fix = "fix"
local hotfix = "hotfix"
local refactor = "refactor"

local large_template = function(variant)
  return fmta(variant .. [[
: <> (#<>)

<>

Issue: #<>
]], {
    i(1),
    i(2),
    i(3),
    rep(2),
  })
end

local medium_template = function(variant)
  return fmta(variant .. [[
: <> (#<>)

Issue: #<>
]], {
    i(1),
    i(2),
    rep(2),
  })
end

local small_template = function(variant)
  return fmta(variant .. [[
: <> (#<>)
]], {
    i(1),
    i(2),
  })
end

local M = {
  s("gfl", large_template(feature)),
  s("gfm", medium_template(feature)),
  s("gfs", small_template(feature)),

  s("gfxl", large_template(fix)),
  s("gfxm", medium_template(fix)),
  s("gfxs", small_template(fix)),

  s("ghfl", large_template(hotfix)),
  s("ghfm", medium_template(hotfix)),
  s("ghfs", small_template(hotfix)),

  s("gcl", large_template(chore)),
  s("gcm", medium_template(chore)),
  s("gcs", small_template(chore)),

  s("grl", large_template(refactor)),
  s("grm", medium_template(refactor)),
  s("grs", small_template(refactor)),
}

return M

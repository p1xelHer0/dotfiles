-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

local lush = require("lush")
local hsl = lush.hsl

-- https://colordesigner.io/gradient-generator/?mode=lch#0D1117-B3B1AD - 27
-- stylua: ignore start
local bg    = hsl("#0d1117")
local fg    = hsl("#b5a488")
local bg_d1 = bg.da(10)
local bg_d2 = bg.da(30)
local bg_l1 = bg.li(5)
local bg_l2 = bg.li(10)

local C = {
  normal = {
    red     = hsl("#c37878"),
    green   = hsl("#7f9375"),
    yellow  = hsl("#c49e6a"),
    blue    = hsl("#477e76"),
    magenta = hsl("#c48884"),
    cyan    = hsl("#b5a488"),
    white   = hsl("#b5a488"),
  },
  bright = {
    black   = hsl("#706957"),
    red     = hsl("#daa4a3"),
    green   = hsl("#a8b6a1"),
    yellow  = hsl("#dabd9a"),
    blue    = hsl("#84a8a1"),
    magenta = hsl("#b5a488"),
    cyan    = hsl("#b5a488"),
    white   = hsl("#ffffff"),
  },
  index = {
    i16     = hsl("#13171c"),
    i17     = hsl("#1c2226"),
    i18     = hsl("#262d30"),
    i19     = hsl("#31383b"),
    i20     = hsl("#3c4445"),
  },
}
-- stylua: ignore end

--- @diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- stylua: ignore start
    Normal        { fg = fg },
    CursorLine    { bg = C.index.i16 },
    CursorLineNr  { fg = C.normal.white, bg = C.index.i16 },
    ColorColumn   { CursorLine },
    CursorColumn  { CursorLine },
    -- Conceal       { },
    -- Cursor        { },
    -- lCursor       { }
    -- CursorIM      { },
    Directory     { fg = C.normal.green, gui = "bold" },
    EndOfBuffer   { fg = C.index.i17 },
    -- TermCursor    { },
    TermCursorNC  { },
    ErrorMsg      { fg = C.normal.red },
    VertSplit     { EndOfBuffer },
    Folded        { fg = C.normal.white },
    FoldColumn    { fg = C.index.i20 },
    SignColumn    { fg = C.bright.black },
    IncSearch     { fg = bg, bg = C.normal.white },
    Substitute    { fg = bg, bg = C.bright.red },
    LineNr        { fg = C.bright.black },
    MatchParen    { fg = C.bright.white, bg = C.normal.blue, gui = "bold" },
    ModeMsg       { Normal },
    MsgArea       { fg = C.bright.black },
    -- MsgSeparator  { },
    MoreMsg       { fg = C.normal.green, gui = "bold" },
    NonText       { EndOfBuffer },
    -- NormalNC      { Normal.li(100) },
    Pmenu         { bg = C.index.i16 },
    PmenuSel      { bg = C.index.i18 },
    PmenuSbar     { bg = C.index.i18 },
    PmenuThumb    { bg = C.bright.black },
    Question      { MoreMsg },
    -- QuickFixLine  { },
    Search        { fg = bg, bg = C.bright.yellow },
    SpecialKey    { fg = bg, bg = C.normal.red, gui = "bold" },
    StatusLine    { fg = C.normal.white },
    StatusLineNC  { fg = C.index.i20 },
    TabLine       { bg = C.index.i17 },
    TabLineFill   { },
    TabLineSel    { },
    Title         { fg = C.normal.magenta, gui = "bold" },
    Visual        { gui = "reverse"},
    -- VisualNOS     { },
    WarningMsg    { fg = C.normal.yellow },
    Whitespace    { fg = C.index.i20 },
    Winseparator  { },
    WildMenu      { PmenuSel },
    -- Underlined    { gui = "underline" },
    -- Ignore        { },
    Error         { ErrorMsg },
    Todo          { fg = bg, bg = C.normal.magenta },
    NormalFloat   { },
    FloatTitle    { Title },
    FloatBorder   { fg = bg_d1, bg = bg_d1 },

    -------------------------------------------------------------------------------------------------------------------
    --- Syntax
    -------------------------------------------------------------------------------------------------------------------
    Comment         { fg = C.bright.black, gui = "italic" },

    Constant        { fg = C.normal.green },
      String        { Constant },
      Character     { Constant },
      Number        { fg = C.normal.blue },
      Boolean       { fg = C.normal.yellow },

    Identifier     { Normal },
      Function     { fg = C.bright.blue },

    Statement         { Normal },
      Conditional     { },
      Repeat          { },
      Label           { },
      Operator        { fg = C.normal.yellow },
      Keyword         { fg = C.normal.green },
      Exception       { fg = C.normal.red },

    PreProc           { Normal },
      -- Include         { },
      -- Define          { },
      -- Macro           { },
      -- PreCondit       { },

    Type              { fg = C.normal.green },
      -- StorageClass    { },
      -- Structure       { },
      -- Typedef         { },

    Special           { Normal },
      -- SpecialChar     { },
      -- Tag             { },
      -- Delimiter       { },
      -- SpecialComment  { },
      -- Debug           { },


    -------------------------------------------------------------------------------------------------------------------
    --- Diagnostics
    -------------------------------------------------------------------------------------------------------------------
    DiagnosticUnnecessary      { fg = Comment.fg },
    DiagnosticError            { ErrorMsg },
    DiagnosticWarn             { WarningMsg },
    DiagnosticInfo             { fg = C.normal.blue },
    DiagnosticHint             { fg = C.normal.white },
    DiagnosticOk               { fg = C.normal.green },
    DiagnosticVirtualTextError { fg = DiagnosticError.fg, bg = DiagnosticError.fg.da(75) },
    DiagnosticVirtualTextWarn  { fg = DiagnosticWarn.fg,  bg = DiagnosticWarn.fg.da(75)  },
    DiagnosticVirtualTextInfo  { fg = DiagnosticInfo.fg,  bg = DiagnosticInfo.fg.da(75)  },
    DiagnosticVirtualTextHint  { fg = DiagnosticHint.fg,  bg = DiagnosticHint.fg.da(75)  },
    DiagnosticVirtualTextOk    { fg = DiagnosticOk.fg,    bg = DiagnosticOk.fg.da(75)    },
    DiagnosticUnderlineError   { sp = DiagnosticError.fg, gui = "undercurl" },
    DiagnosticUnderlineWarn    { sp = DiagnosticWarn.fg,  gui = "undercurl" },
    DiagnosticUnderlineInfo    { sp = DiagnosticInfo.fg,  gui = "undercurl" },
    DiagnosticUnderlineHint    { sp = DiagnosticHint.fg,  gui = "undercurl" },
    DiagnosticUnderlineOk      { sp = DiagnosticOk.fg,    gui = "underline" },
    -- DiagnosticFloatingError    { },
    -- DiagnosticFloatingWarn     { },
    -- DiagnosticFloatingInfo     { },
    -- DiagnosticFloatingHint     { },
    -- DiagnosticFloatingOk       { },
    -- DiagnosticSignError        { },
    -- DiagnosticSignWarn         { },
    -- DiagnosticSignInfo         { },
    -- DiagnosticSignHint         { },
    -- DiagnosticSignOk           { },
    SpellBad                   { DiagnosticUnderlineError },
    SpellCap                   { DiagnosticUnderlineWarn },
    SpellLocal                 { DiagnosticUnderlineInfo },
    SpellRare                  { DiagnosticUnderlineHint },


    -------------------------------------------------------------------------------------------------------------------
    --- Tree-sitter
    -------------------------------------------------------------------------------------------------------------------
    -- sym"@text.literal"        { },
    -- sym"@text.reference"      { },
    -- sym"@text.title"          { },
    -- sym"@text.uri"            { },
    -- sym"@text.underline"      { },
    -- sym"@text.todo"           { },
    -- sym"@comment"             { },
    -- sym"@punctuation"         { },
    -- sym"@constant"            { },
    -- sym"@constant.builtin"    { },
    -- sym"@constant.macro"      { },
    -- sym"@define"              { },
    -- sym"@macro"               { },
    -- sym"@string"              { },
    -- sym"@string.escape"       { },
    -- sym"@string.special"      { },
    -- sym"@character"           { },
    -- sym"@character.special"   { },
    -- sym"@number"              { },
    -- sym"@boolean"             { },
    -- sym"@float"               { },
    -- sym"@function"            { },
    -- sym"@function.builtin"    { },
    -- sym"@function.macro"      { },
    -- sym"@parameter"           { },
    -- sym"@method"              { },
    -- sym"@field"               { },
    -- sym"@property"            { },
    -- sym"@constructor"         { },
    -- sym"@conditional"         { },
    -- sym"@repeat"              { },
    -- sym"@label"               { },
    -- sym"@operator"            { },
    -- sym"@keyword"             { },
    -- sym"@exception"           { },
    -- sym"@variable"            { },
    -- sym"@type"                { },
    -- sym"@type.definition"     { },
    -- sym"@storageclass"        { },
    -- sym"@structure"           { },
    -- sym"@namespace"           { },
    -- sym"@include"             { },
    -- sym"@preproc"             { },
    -- sym"@debug"               { },
    -- sym"@tag"                 { },


    -------------------------------------------------------------------------------------------------------------------
    --- LSP
    -------------------------------------------------------------------------------------------------------------------
    -- sym"@lsp.type.class"          { },
    -- sym"@lsp.type.decorator"      { },
    -- sym"@lsp.type.enum"           { },
    -- sym"@lsp.type.enumMember"     { },
    -- sym"@lsp.type.function"       { },
    -- sym"@lsp.type.interface"      { },
    -- sym"@lsp.type.macro"          { },
    -- sym"@lsp.type.method"         { },
    -- sym"@lsp.type.namespace"      { },
    -- sym"@lsp.type.parameter"      { },
    -- sym"@lsp.type.property"       { },
    -- sym"@lsp.type.struct"         { },
    -- sym"@lsp.type.type"           { },
    -- sym"@lsp.type.typeParameter"  { },
    -- sym"@lsp.type.variable"       { },

    -- LspReferenceText              { },
    -- LspReferenceRead              { },
    -- LspReferenceWrite             { },
    -- LspCodeLens                   { },
    -- LspCodeLensSeparator          { },
    -- LspSignatureActiveParameter   { },


    -------------------------------------------------------------------------------------------------------------------
    --- Diff & Git
    -------------------------------------------------------------------------------------------------------------------
    DiffAdd     { bg = C.normal.green.da(55) },
    DiffDelete  { bg = C.normal.red.da(55) },
    DiffChange  { bg = C.normal.yellow.da(55) },
    DiffText    { bg = C.normal.blue.da(50) },
    GitAdd      { fg = C.normal.green },
    GitDelete   { fg = C.normal.red },
    GitChange   { fg = C.normal.yellow },
    GitNew      { fg = C.normal.blue },


    -------------------------------------------------------------------------------------------------------------------
    --- Plugins
    -------------------------------------------------------------------------------------------------------------------
    GitSignsAdd           { GitAdd },
    GitSignsDelete        { GitDelete },
    GitSignsChange        { GitChange },
    GitSignsNew           { GitNew },

    NeogitDiffAdd         { DiffAdd },
    NeogitDiffDelete      { DiffDelete },
    NeogitDiffChange      { DiffChange },
    NeogitDiffText        { DiffText },

    NvimTreeGitDirty      { GitChange },
    NvimTreeGitStaged     { GitNew },
    NvimTreeGitMerge      { GitDelete },
    NvimTreeGitRenamed    { GitAdd },
    NvimTreeGitNew        { GitAdd },
    NvimTreeGitDeleted    { GitDelete },


    TelescopeBorder           { FloatBorder },
    TelescopePreviewBorder    { bg = bg_d1 },
    TelescopePreviewTitle     { Substitute },
    TelescopePreviewNormal    { bg = bg_d1 },

    TelescopePromptBorder     { bg = bg_l1 },
    TelescopePromptTitle      { fg = bg, bg = ErrorMsg.fg },
    TelescopePromptNormal     { bg = bg_l1 },
    TelescopePromptCounter    { fg = Number.fg },
    TelescopePromptPrefix     { fg = Operator.fg },

    TelescopeResultsBorder    { bg = bg_d2 },
    TelescopeResultsTitle     { fg = bg, bg = Constant.fg },
    TelescopeResultsNormal    { bg = bg_d2 },

-- TelescopeTitle|1 col 1| TelescopeTitle
-- TelescopeBorder|1 col 1| TelescopeBorder
-- TelescopeNormal|1 col 1| TelescopeNormal
-- TelescopeMatching|1 col 1| TelescopeMatching
-- TelescopeMultiIcon|1 col 1| TelescopeMultiIcon
-- TelescopeSelection|1 col 1| TelescopeSelection
-- TelescopePreviewDate|1 col 1| TelescopePreviewDate
-- TelescopePreviewLine|1 col 1| TelescopePreviewLine
-- TelescopePreviewLink|1 col 1| TelescopePreviewLink
-- TelescopePreviewPipe|1 col 1| TelescopePreviewPipe
-- TelescopePreviewRead|1 col 1| TelescopePreviewRead
-- TelescopePreviewSize|1 col 1| TelescopePreviewSize
-- TelescopePreviewUser|1 col 1| TelescopePreviewUser
-- TelescopePreviewBlock|1 col 1| TelescopePreviewBlock
-- TelescopePreviewGroup|1 col 1| TelescopePreviewGroup
-- TelescopePreviewMatch|1 col 1| TelescopePreviewMatch
-- TelescopePreviewTitle|1 col 1| TelescopePreviewTitle
-- TelescopePreviewWrite|1 col 1| TelescopePreviewWrite
-- TelescopePromptPrefix|1 col 1| TelescopePromptPrefix
-- TelescopeResultsClass|1 col 1| TelescopeResultsClass
-- TelescopeResultsField|1 col 1| TelescopeResultsField
-- TelescopeResultsTitle|1 col 1| TelescopeResultsTitle
-- TelescopePreviewBorder|1 col 1| TelescopePreviewBorder
-- TelescopePreviewHyphen|1 col 1| TelescopePreviewHyphen
-- TelescopePreviewNormal|1 col 1| TelescopePreviewNormal
-- TelescopePreviewSocket|1 col 1| TelescopePreviewSocket
-- TelescopePreviewSticky|1 col 1| TelescopePreviewSticky
-- TelescopePromptCounter|1 col 1| TelescopePromptCounter
-- TelescopeResultsBorder|1 col 1| TelescopeResultsBorder
-- TelescopeResultsLineNr|1 col 1| TelescopeResultsLineNr
-- TelescopeResultsMethod|1 col 1| TelescopeResultsMethod
-- TelescopeResultsNormal|1 col 1| TelescopeResultsNormal
-- TelescopeResultsNumber|1 col 1| TelescopeResultsNumber
-- TelescopeResultsStruct|1 col 1| TelescopeResultsStruct
-- TelescopeMultiSelection|1 col 1| TelescopeMultiSelection
-- TelescopePreviewCharDev|1 col 1| TelescopePreviewCharDev
-- TelescopePreviewExecute|1 col 1| TelescopePreviewExecute
-- TelescopePreviewMessage|1 col 1| TelescopePreviewMessage
-- TelescopeResultsComment|1 col 1| TelescopeResultsComment
-- TelescopeResultsDiffAdd|1 col 1| TelescopeResultsDiffAdd
-- TelescopeSelectionCaret|1 col 1| TelescopeSelectionCaret
-- TelescopeResultsConstant|1 col 1| TelescopeResultsConstant
-- TelescopeResultsFunction|1 col 1| TelescopeResultsFunction
-- TelescopeResultsOperator|1 col 1| TelescopeResultsOperator
-- TelescopeResultsVariable|1 col 1| TelescopeResultsVariable
-- TelescopePreviewDirectory|1 col 1| TelescopePreviewDirectory
-- TelescopeResultsDiffChange|1 col 1| TelescopeResultsDiffChange
-- TelescopeResultsDiffDelete|1 col 1| TelescopeResultsDiffDelete
-- TelescopeResultsIdentifier|1 col 1| TelescopeResultsIdentifier
-- TelescopeResultsDiffUntracked|1 col 1| TelescopeResultsDiffUntracked
-- TelescopeResultsSpecialComment|1 col 1| TelescopeResultsSpecialComment
-- TelescopePreviewMessageFillchar|1 col 1| TelescopePreviewMessageFillchar


    -- NvimTreeBookmark          { Normal },
    -- NvimTreeSymlink           { },
    -- NvimTreeImageFile         { Normal },
    -- NvimTreeExecFile          { },
    NvimTreeFolderIcon        { Directory },
    -- NvimTreeOpenedFile        { },
    -- NvimTreeRootFolder        { },
    -- NvimTreeSpecialFile       { },
    -- NvimTreeIndentMarker      { },
    -- NvimTreeModifiedFile      { },
    -- NvimTreeWindowPicker      { },
    -- NvimTreeLiveFilterPrefix  { },


    MiniIndentscopeSymbol { fg = CursorLine.bg },
  }
end)

return theme
-- vi:nowrap

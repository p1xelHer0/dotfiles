-- vim: set nowrap nomodeline:
local lush = require("lush")
local hsl = lush.hsl

-- https://colordesigner.io/gradient-generator/?mode=lch#0D1117-B3B1AD - 27
-- stylua: ignore start
local bg    = hsl("#0d1117")
local fg    = hsl("#b5a488")
local c = {
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

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- stylua: ignore start
    Normal       { fg = fg, bg = bg }, -- Normal text
    CursorLine   { bg = c.index.i16 }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLineNr { fg = c.bright.black, bg = c.index.i16 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    ColorColumn  { CursorLine }, -- Columns set with 'colorcolumn'
    CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    -- Conceal      { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- Character under the cursor
    -- lCursor      { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- Like Cursor, but used when in IME mode |CursorIM|
    Directory    { fg = c.normal.green, gui = "bold" }, -- Directory names (and other special names in listings)
   EndOfBuffer  { fg = c.index.i17 }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- Cursor in a focused terminal
    -- TermCursorNC { }, -- Cursor in an unfocused terminal
    ErrorMsg     { fg = c.normal.red }, -- Error messages on the command line
    VertSplit    { fg = bg }, -- Column separating vertically split windows
    Folded       { fg = c.normal.white }, -- Line used for closed folds
    FoldColumn   { fg = c.index.i20 }, -- 'foldcolumn'
    SignColumn   { fg = c.bright.black }, -- Column where |signs| are displayed
    IncSearch    { fg = bg, bg = c.normal.white }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute   { fg = bg, bg = c.bright.red }, -- |:substitute| replacement text highlighting
    LineNr       { fg = c.index.i20 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    MatchParen   { fg = c.bright.white, bg = c.normal.blue, gui = "bold"}, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg      { Normal }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea      { fg = c.bright.black }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { fg = c.normal.green, gui = "bold" }, -- |more-prompt|
    NonText      { EndOfBuffer }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    NormalFloat  { }, -- Normal text in floating windows.
    -- NormalNC     { Normal.li(100) }, -- normal text in non-current windows
    Pmenu        { bg = c.index.i16 }, -- Popup menu: Normal item.
    PmenuSel     { bg = c.index.i18 }, -- Popup menu: Selected item.
    PmenuSbar    { bg = c.index.i18 }, -- Popup menu: Scrollbar.
    PmenuThumb   { bg = c.bright.black }, -- Popup menu: Thumb of the scrollbar.
    Question     { MoreMsg }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search       { fg = bg, bg = c.bright.yellow }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    SpecialKey   { fg = bg, bg = c.normal.red, gui = "bold" }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    StatusLine   { fg = c.normal.white }, -- Status line of current window
    StatusLineNC { fg = c.index.i20 }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { bg = c.index.i17 }, -- Tab pages line, not active tab page label
    TabLineFill  { }, -- Tab pages line, where there are no labels
    TabLineSel   { }, -- Tab pages line, active tab page label
    Title        { fg = c.normal.magenta, gui = "bold" }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual       { gui = "reverse"}, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { fg = c.normal.yellow }, -- Warning messages
    Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu     { PmenuSel }, -- Current match in 'wildmenu' completion
    Underlined   { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore       { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error        { ErrorMsg }, -- Any erroneous construct
    Todo         { fg = bg, bg = c.normal.magenta }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX


    -------------------------------------------------------------------------------------------------------------------
    --- Syntax
    -------------------------------------------------------------------------------------------------------------------
    Comment         { fg = c.bright.black, gui = "italic" }, -- Any comment

    Constant        { fg = c.normal.green                 }, -- (*) Any constant
    -- String         {                                   }, --   A string constant: "this is a string"
    -- Character      {                                   }, --   A character constant: 'c', '\n'
    Number         { fg = c.normal.blue                   }, --   A number constant: 234, 0xff
    -- Float          {                                   }, --   A floating point constant: 2.3e10
    Boolean        { fg = c.normal.yellow                 }, --   A boolean constant: TRUE, false

    Identifier     { Normal                               }, -- (*) Any variable name
    -- Function       {                                   }, --   Function name (also: methods for classes)

    Statement      { Normal                               }, -- (*) Any statement
    -- Conditional    {                                   }, --   if, then, else, endif, switch, etc.
    -- Repeat         {                                   }, --   for, do, while, etc.
    -- Label          {                                   }, --   case, default, etc.
    Operator       { fg = c.normal.yellow                 }, --   "sizeof", "+", "*", etc.
    Keyword        { fg = c.normal.green                  }, --   any other keyword
    Exception      { fg = c.normal.red                    }, --   try, catch, throw

    PreProc        { Normal                               }, -- (*) Generic Preprocessor
    -- Include        {                                   }, --   Preprocessor #include
    -- Define         {                                   }, --   Preprocessor #define
    -- Macro          {                                   }, --   Same as Define
    -- PreCondit      {                                   }, --   Preprocessor #if, #else, #endif, etc.

    Type           { fg = c.normal.green                  }, -- (*) int, long, char, etc.
    -- StorageClass   {                                   }, --   static, register, volatile, etc.
    -- Structure      {                                   }, --   struct, union, enum, etc.
    -- Typedef        {                                   }, --   A typedef

    Special        { Normal                               }, -- (*) Any special symbol
    -- SpecialChar    {                                   }, --   Special character in a constant
    -- Tag            {                                   }, --   You can use CTRL-] on this
    -- Delimiter      {                                   }, --   Character that needs attention
    -- SpecialComment {                                   }, --   Special things inside a comment (e.g. '\n')
    -- Debug          {                                   }, --   Debugging statements


    -------------------------------------------------------------------------------------------------------------------
    --- Diagnostics
    -------------------------------------------------------------------------------------------------------------------
    DiagnosticUnnecessary      { fg = Comment.fg                                         }, -- Comment
    DiagnosticError            { ErrorMsg                                                }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { WarningMsg                                              }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { fg = c.normal.blue                                      }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg = c.normal.white                                     }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk               { fg = c.normal.green                                     }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticVirtualTextError { fg = DiagnosticError.fg, bg = DiagnosticError.fg.da(75) }, -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn  { fg = DiagnosticWarn.fg,  bg = DiagnosticWarn.fg.da(75)  }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextInfo  { fg = DiagnosticInfo.fg,  bg = DiagnosticInfo.fg.da(75)  }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextHint  { fg = DiagnosticHint.fg,  bg = DiagnosticHint.fg.da(75)  }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextOk    { fg = DiagnosticOk.fg,    bg = DiagnosticOk.fg.da(75)    }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticUnderlineError   { sp = DiagnosticError.fg, gui = "undercurl"              }, -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    { sp = DiagnosticWarn.fg,  gui = "undercurl"              }, -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    { sp = DiagnosticInfo.fg,  gui = "undercurl"              }, -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    { sp = DiagnosticHint.fg,  gui = "undercurl"              }, -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk      { sp = DiagnosticOk.fg,    gui = "underline"              }, -- Used to underline "Hint" diagnostics.
    -- DiagnosticFloatingError    { }, -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { }, -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { }, -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { }, -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { }, -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { }, -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { }, -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { }, -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { }, -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { }, -- Used for "Ok" signs in sign column.
    SpellBad                   { DiagnosticUnderlineError }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap                   { DiagnosticUnderlineWarn }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal                 { DiagnosticUnderlineInfo }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare                  { DiagnosticUnderlineHint }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.


    -------------------------------------------------------------------------------------------------------------------
    --- Tree-sitter
    -------------------------------------------------------------------------------------------------------------------
    sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag


    -------------------------------------------------------------------------------------------------------------------
    --- LSP
    -------------------------------------------------------------------------------------------------------------------
    -- sym"@lsp.type.class"         { }, -- Structure
    -- sym"@lsp.type.decorator"     { }, -- Function
    -- sym"@lsp.type.enum"          { }, -- Structure
    -- sym"@lsp.type.enumMember"    { }, -- Constant
    -- sym"@lsp.type.function"      { }, -- Function
    -- sym"@lsp.type.interface"     { }, -- Structure
    -- sym"@lsp.type.macro"         { }, -- Macro
    -- sym"@lsp.type.method"        { }, -- Function
    -- sym"@lsp.type.namespace"     { }, -- Structure
    -- sym"@lsp.type.parameter"     { }, -- Identifier
    -- sym"@lsp.type.property"      { }, -- Identifier
    -- sym"@lsp.type.struct"        { }, -- Structure
    -- sym"@lsp.type.type"          { }, -- Type
    -- sym"@lsp.type.typeParameter" { }, -- TypeDef
    -- sym"@lsp.type.variable"      { }, -- Identifier

    -- LspReferenceText            { }, -- Used for highlighting "text" references
    -- LspReferenceRead            { }, -- Used for highlighting "read" references
    -- LspReferenceWrite           { }, -- Used for highlighting "write" references
    -- LspCodeLens                 { }, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { }, -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { }, -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.


    -------------------------------------------------------------------------------------------------------------------
    --- Diff & Git
    -------------------------------------------------------------------------------------------------------------------
    DiffAdd               { bg = c.normal.green.da(55)  }, -- Diff mode: Added line |diff.txt|
    DiffDelete            { bg = c.normal.red.da(55)    }, -- Diff mode: Deleted line |diff.txt|
    DiffChange            { bg = c.normal.yellow.da(55) }, -- Diff mode: Changed line |diff.txt|
    DiffText              { bg = c.normal.blue.da(50)   }, -- Diff mode: Changed text within a changed line |diff.txt|
    GitAdd                { fg = c.normal.green                                                  },
    GitDelete             { fg = c.normal.red                                                    },
    GitChange             { fg = c.normal.yellow                                                 },
    GitNew                { fg = c.normal.blue                                                   },


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


    MiniIndentscopeSymbol { fg = CursorLine.bg },

    NvimTreeGitDirty      { GitChange },
    NvimTreeGitStaged     { GitNew },
    NvimTreeGitMerge      { GitDelete },
    NvimTreeGitRenamed    { GitAdd },
    NvimTreeGitNew        { GitAdd },
    NvimTreeGitDeleted    { GitDelete },

    -- NvimTreeBookmark { Normal },
    -- NvimTreeSymlink { },
    -- NvimTreeImageFile { Normal },
    NvimTreeFolderIcon { Directory },
    -- NvimTreeOpenedFile { },
    -- NvimTreeRootFolder { },
    -- NvimTreeSpecialFile { },
    -- NvimTreeIndentMarker { },
    -- NvimTreeModifiedFile { },
    -- NvimTreeWindowPicker { },
    -- NvimTreeLiveFilterPrefix { },
  }
end)

return theme

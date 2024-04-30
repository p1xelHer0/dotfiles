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
-- https://github.com/neovim/neovim/pull/26334
local lush = require("lush")
local hsl = lush.hsl

-- https://colordesigner.io/gradient-generator/?mode=lch#0D1117-B3B1AD - 27
-- stylua: ignore start
local bg    = hsl("#0d1117")
local fg    = hsl("#b5a488")

local C = {
  normal = {
    red     = hsl("#c37878"),
    green   = hsl("#7f9375"),
    yellow  = hsl("#c49e6a"),
    blue    = hsl("#84a8a1"),
    magenta = hsl("#7b7c94"),
    cyan    = hsl("#477e76"),
    white   = hsl("#dbc7a5"),
  },
  bright = {
    black   = hsl("#706957"),
    red     = hsl("#ff9d9d"),
    green   = hsl("#00ff00"),
    yellow  = hsl("#dabd9a"),
    blue    = hsl("#00b5ea"),
    magenta = hsl("#dea1bb"),
    cyan    = hsl("#73ccbf"),
    white   = hsl("#ececec"),
  },
  index = {
    i16     = hsl("#111c1f"),
    i17     = hsl("#152326"),
    i18     = hsl("#19292e"),
    i19     = hsl("#1d3036"),
    i20     = hsl("#22373d"),
  },
  alert = {
    red     = hsl("#ff0000"),
    green   = hsl("#00ff00"),
    blue    = hsl("#00fbff"),
  }
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
    LineNr        { fg = C.bright.black },
    MatchParen    { fg = bg, bg = C.bright.green },
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
    QuickFixLine  { fg = C.normal.cyan },
    Search        { fg = bg, bg = C.bright.yellow },
    CurSearch     { fg = bg, bg = C.alert.green },
    IncSearch     { Search },
    Substitute    { fg = bg, bg = C.bright.yellow },
    SpecialKey    { fg = bg, bg = C.normal.red, gui = "bold" },
    StatusLine    { fg = bg, bg = C.bright.black },
    StatusLineNC  { fg = C.bright.black },
    TabLine       { fg = C.bright.black },
    TabLineFill   { },
    TabLineSel    { },
    Title         { fg = C.normal.magenta, gui = "bold" },
    Visual        { fg = bg, bg = C.normal.magenta },
    -- VisualNOS     { },
    WarningMsg    { fg = C.normal.yellow },
    Whitespace    { fg = C.index.i20 },
    Winseparator  { },
    WildMenu      { PmenuSel },
    -- Underlined    { gui = "underline" },
    -- Ignore        { },
    Error         { ErrorMsg },
    Todo          { fg = bg, bg = C.normal.magenta },
    -- NormalFloat   { },
    FloatTitle    { Title },
    -- FloatBorder   { fg = C.index.i20, bg = C.index.i20 },

    -------------------------------------------------------------------------------------------------------------------
    --- Syntax
    -------------------------------------------------------------------------------------------------------------------
    Comment         { fg = C.bright.black, gui = "italic" },

    Constant        { fg = C.normal.green },
    String        { Constant },
    Character     { Constant },
    Number        { fg = C.normal.cyan },
    Boolean       { fg = C.normal.yellow },

    Identifier     { Normal },
    Function     { fg = C.normal.blue },

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
    Delimiter       { fg = C.bright.black },
    -- SpecialComment  { },
    -- Debug           { },


    -------------------------------------------------------------------------------------------------------------------
    --- Tree-sitter - [h: treesitter-hightlight-groups]
    -------------------------------------------------------------------------------------------------------------------
    sym("@variable")                    { Normal }, -- various variable names
    -- sym("@variable.builtin")            { }, -- built-in variable names (e.g. `this`, `self`)
    -- sym("@variable.parameter")          { }, -- parameters of a function
    -- sym("@variable.parameter.builtin")  { }, -- special parameters (e.g. `_`, `it`)
    -- sym("@variable.member")             { }, -- object and struct fields

    -- sym("@constant")                    { }, -- constant identifiers
    -- sym("@constant.builtin")            { }, -- built-in constant values
    -- sym("@constant.macro")              { }, -- constants defined by the preprocessor

    -- sym("@module")                      { }, -- modules or namespaces
    -- sym("@module.builtin")              { }, -- built-in modules or namespaces
    -- sym("@label")                       { }, -- `GOTO` and other labels (e.g. `label:` in C), including heredoc labels

    -- sym("@string")                      { }, -- string literals
    -- sym("@string.documentation")        { }, -- string documenting code (e.g. Python docstrings)
    -- sym("@string.regexp")               { }, -- regular expressions
    -- sym("@string.escape")               { }, -- escape sequences
    -- sym("@string.special")              { }, -- other special strings (e.g. dates)
    -- sym("@string.special.symbol")       { }, -- symbols or atoms
    -- sym("@string.special.path")         { }, -- filenames
    -- sym("@string.special.url")          { }, -- URIs (e.g. hyperlinks)

    -- sym("@character")                   { }, -- character literals
    -- sym("@character.special")           { }, -- special characters (e.g. wildcards)

    -- sym("@boolean")                     { }, -- boolean literals
    -- sym("@number")                      { }, -- numeric literals
    -- sym("@number.float")                { }, -- floating-point number literals

    -- sym("@type")                        { }, -- type or class definitions and annotations
    -- sym("@type.builtin")                { }, -- built-in types
    -- sym("@type.definition")             { }, -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)

    -- sym("@attribute")                   { }, -- attribute annotations (e.g. Python decorators, Rust lifetimes)
    -- sym("@attribute.builtin")           { }, -- builtin annotations (e.g. `@property` in Python)
    -- sym("@property")                    { }, -- the key in key/value pairs

    -- sym("@function")                    { }, -- function definitions
    -- sym("@function.builtin")            { }, -- built-in functions
    -- sym("@function.call")               { }, -- function calls
    -- sym("@function.macro")              { }, -- preprocessor macros

    -- sym("@function.method")             { }, -- method definitions
    -- sym("@function.method.call")        { }, -- method calls

    -- sym("@constructor")                 { }, -- constructor calls and definitions
    -- sym("@operator")                    { }, -- symbolic operators (e.g. `+`, `*`)

    -- sym("@keyword")                     { }, -- keywords not fitting into specific categories
    -- sym("@keyword.coroutine")           { }, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
    -- sym("@keyword.function")            { }, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    -- sym("@keyword.operator")            { }, -- operators that are English words (e.g. `and`, `or`)
    -- sym("@keyword.import")              { }, -- keywords for including modules (e.g. `import`, `from` in Python)
    -- sym("@keyword.type")                { }, -- keywords defining composite types (e.g. `struct`, `enum`)
    -- sym("@keyword.modifier")            { }, -- keywords defining type modifiers (e.g. `const`, `static`, `public`)
    -- sym("@keyword.repeat")              { }, -- keywords related to loops (e.g. `for`, `while`)
    -- sym("@keyword.return")              { }, -- keywords like `return` and `yield`
    -- sym("@keyword.debug")               { }, -- keywords related to debugging
    -- sym("@keyword.exception")           { }, -- keywords related to exceptions (e.g. `throw`, `catch`)

    -- sym("@keyword.conditional")         { }, -- keywords related to conditionals (e.g. `if`, `else`)
    -- sym("@keyword.conditional.ternary") { }, -- ternary operator (e.g. `?`, `:`)

    -- sym("@keyword.directive")           { }, -- various preprocessor directives and shebangs
    -- sym("@keyword.directive.define")    { }, -- preprocessor definition directives

    -- sym("@punctuation.delimiter")       { }, -- delimiters (e.g. `;`, `.`, `,`)
    -- sym("@punctuation.bracket")         { }, -- brackets (e.g. `()`, `{}`, `[]`)
    -- sym("@punctuation.special")         { }, -- special symbols (e.g. `{}` in string interpolation)

    -- sym("@comment")                     { }, -- line and block comments
    -- sym("@comment.documentation")       { }, -- comments documenting code

    -- sym("@comment.error")               { }, -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
    -- sym("@comment.warning")             { }, -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
    -- sym("@comment.todo")                { }, -- todo-type comments (e.g. `TODO`, `WIP`)
    -- sym("@comment.note")                { }, -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)

    -- sym("@markup.strong")               { }, -- bold text
    -- sym("@markup.italic")               { }, -- italic text
    -- sym("@markup.strikethrough")        { }, -- struck-through text
    -- sym("@markup.underline")            { }, -- underlined text (only for literal underline markup!)

    -- sym("@markup.heading")              { }, -- headings, titles (including markers)
    -- sym("@markup.heading.1")            { }, -- top-level heading
    -- sym("@markup.heading.2")            { }, -- section heading
    -- sym("@markup.heading.3")            { }, -- subsection heading
    -- sym("@markup.heading.4")            { }, -- and so on
    -- sym("@markup.heading.5")            { }, -- and so forth
    -- sym("@markup.heading.6")            { }, -- six levels ought to be enough for anybody

    -- sym("@markup.quote")                { }, -- block quotes
    -- sym("@markup.math")                 { }, -- math environments (e.g. `$ ... $` in LaTeX)

    -- sym("@markup.link")                 { }, -- text references, footnotes, citations, etc.
    -- sym("@markup.link.label")           { }, -- link, reference descriptions
    -- sym("@markup.link.url")             { }, -- URL-style links

    -- sym("@markup.raw")                  { }, -- literal or verbatim text (e.g. inline code)
    -- sym("@markup.raw.block")            { }, -- literal or verbatim text as a stand-alone block

    -- sym("@markup.list")                 { }, -- list markers
    -- sym("@markup.list.checked")         { }, -- checked todo-style list markers
    -- sym("@markup.list.unchecked")       { }, -- unchecked todo-style list markers

    -- sym("@diff.plus")                   { }, -- added text (for diff files)
    -- sym("@diff.minus")                  { }, -- deleted text (for diff files)
    -- sym("@diff.delta")                  { }, -- changed text (for diff files)

    -- sym("@tag")                         { }, -- XML-style tag names (e.g. in XML, HTML, etc.)
    -- sym("@tag.builtin")                 { }, -- XML-style tag names (e.g. HTML5 tags)
    -- sym("@tag.attribute")               { }, -- XML-style tag attributes
    -- sym("@tag.delimiter")               { }, -- XML-style tag delimiters

    -- TreesitterContext { },
    -- TreesitterContextLineNumber { },
    -- TreesitterContextSeparator { },
    -- TreesitterContextBottom { },
    -- TreesitterContextLineNumberBottom { },

    -------------------------------------------------------------------------------------------------------------------
    --- LSP - [h: lsp-semantic-highlight]
    -------------------------------------------------------------------------------------------------------------------
    -- sym("@lsp.type.class")          { }, -- Identifiers that declare or reference a class type
    -- sym("@lsp.type.comment")        { }, -- Tokens that represent a comment
    -- sym("@lsp.type.decorator")      { }, -- Identifiers that declare or reference decorators and annotations
    -- sym("@lsp.type.enum")           { }, -- Identifiers that declare or reference an enumeration type
    -- sym("@lsp.type.enumMember")     { }, -- Identifiers that declare or reference an enumeration property, constant, or member
    -- sym("@lsp.type.event")          { }, -- Identifiers that declare an event property
    -- sym("@lsp.type.function")       { }, -- Identifiers that declare a function
    -- sym("@lsp.type.interface")      { }, -- Identifiers that declare or reference an interface type
    -- sym("@lsp.type.keyword")        { }, -- Tokens that represent a language keyword
    -- sym("@lsp.type.macro")          { }, -- Identifiers that declare a macro
    -- sym("@lsp.type.method")         { }, -- Identifiers that declare a member function or method
    -- sym("@lsp.type.modifier")       { }, -- Tokens that represent a modifier
    -- sym("@lsp.type.namespace")      { }, -- Identifiers that declare or reference a namespace, module, or package
    -- sym("@lsp.type.number")         { }, -- Tokens that represent a number literal
    -- sym("@lsp.type.operator")       { }, -- Tokens that represent an operator
    -- sym("@lsp.type.parameter")      { }, -- Identifiers that declare or reference a function or method parameters
    -- sym("@lsp.type.property")       { }, -- Identifiers that declare or reference a member property, member field, or member variable
    -- sym("@lsp.type.regexp")         { }, -- Tokens that represent a regular expression literal
    -- sym("@lsp.type.string")         { }, -- Tokens that represent a string literal
    -- sym("@lsp.type.struct")         { }, -- Identifiers that declare or reference a struct type
    -- sym("@lsp.type.type")           { }, -- Identifiers that declare or reference a type that is not covered above
    -- sym("@lsp.type.typeParameter")  { }, -- Identifiers that declare or reference a type parameter
    -- sym("@lsp.type.variable")       { }, -- Identifiers that declare or reference a local or global variable
    --
    -- sym("@lsp.mod.abstract")        { }, -- Types and member functions that are abstract
    -- sym("@lsp.mod.async")           { }, -- Functions that are marked async
    -- sym("@lsp.mod.declaration")     { }, -- Declarations of symbols
    -- sym("@lsp.mod.defaultLibrary")  { }, -- Symbols that are part of the standard library
    -- sym("@lsp.mod.definition")      { }, -- Definitions of symbols, for example, in header files
    -- sym("@lsp.mod.deprecated")      { }, -- Symbols that should no longer be used
    -- sym("@lsp.mod.documentation")   { }, -- Occurrences of symbols in documentation
    -- sym("@lsp.mod.modification")    { }, -- Variable references where the variable is assigned to
    -- sym("@lsp.mod.readonly")        { }, -- Readonly variables and member fields (constants)
    -- sym("@lsp.mod.static")          { }, -- Class members (static members)


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
    --- Diff & Git
    -------------------------------------------------------------------------------------------------------------------
    DiffAdd     { fg = C.normal.blue, bg = C.normal.blue.da(80) },
    DiffDelete  { fg = C.normal.yellow, bg = C.normal.yellow.da(80) },
    DiffChange  { bg = C.normal.yellow.da(55) },
    DiffText    { bg = C.normal.blue.da(50) },
    GitAdd      { fg = C.normal.blue },
    GitDelete   { fg = C.normal.yellow },
    GitChange   { fg = C.bright.yellow },
    GitNew      { fg = C.bright.blue },


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


    -- TelescopeBorder           { FloatBorder },
    TelescopePreviewBorder    { bg = C.index.i20 },
    TelescopePreviewTitle     { Substitute },
    TelescopePreviewNormal    { bg = C.index.i20 },

    TelescopePromptBorder     { bg = C.index.i16 },
    TelescopePromptTitle      { fg = bg, bg = ErrorMsg.fg },
    TelescopePromptNormal     { bg = C.index.i16 },
    TelescopePromptCounter    { fg = Number.fg },
    TelescopePromptPrefix     { fg = Operator.fg },

    TelescopeResultsBorder    { bg = C.index.i16 },
    TelescopeResultsTitle     { fg = bg, bg = Constant.fg },
    TelescopeResultsNormal    { bg = C.index.i16 },

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

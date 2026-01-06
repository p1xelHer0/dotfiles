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
    yellow  = hsl("#ffff00"),
    blue    = hsl("#0000ff"),
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
    EndOfBuffer   { fg = C.index.i16 },
    -- TermCursor    { },
    TermCursorNC  { },
    ErrorMsg      { fg = C.normal.red },
    VertSplit     { EndOfBuffer },
    Folded        { fg = C.normal.white },
    FoldColumn    { fg = C.index.i20 },
    SignColumn    { fg = C.bright.black },
    LineNr        { fg = C.bright.black },
    MatchParen    { fg = fg, bg = C.alert.blue },
    ModeMsg       { Normal },
    MsgArea       { fg = C.bright.black },
    -- MsgSeparator  { },
    MoreMsg       { fg = C.normal.green, gui = "bold" },
    NonText       { EndOfBuffer },
    -- NormalNC      { Normal.li(100) },
    -- TODO: Sort these out, create some kind of grouping with Float, TeleScope, Pmenu, etc
    Pmenu         { bg = C.index.i17 },
    PmenuSel      { gui = "reverse" },
    PmenuSbar     { bg = C.index.i18 },
    PmenuThumb    { bg = C.bright.black },
    Question      { MoreMsg },
    QuickFixLine  { fg = C.normal.cyan },

    -- TODO: Sort these out, create some kind of grouping for Selections Search, PmenuSel, CurSearch, TelescopeMatching
    Search        { fg = bg, bg = C.normal.blue },
    CurSearch     { fg = bg, bg = C.alert.yellow },
    IncSearch     { fg = bg, bg = C.alert.green },
    Substitute    { gui = "reverse" },
    SpecialKey    { fg = bg, bg = C.normal.magenta },
    StatusLine    { fg = C.bright.black },
    StatusLineNC  { fg = C.bright.black },
    TabLine       { fg = C.bright.black },
    TabLineFill   { },
    TabLineSel    { },
    Title         { fg = C.normal.magenta, gui = "bold" },
    Visual        { fg = bg, bg = C.normal.blue },
    -- VisualNOS     { },
    WarningMsg    { fg = C.normal.yellow },
    Whitespace    { fg = C.index.i20 },
    Winseparator  { },
    WildMenu      { PmenuSel },
    Underlined    { gui = "underline" },
    Ignore        { },
    Error         { ErrorMsg },
    Todo          { fg = bg, bg = C.normal.magenta },
    NormalFloat   { CursorLine },
    FloatBorder   { NormalFloat },
    FloatTitle    { Title },

    -------------------------------------------------------------------------------------------------------------------
    --- Syntax
    -------------------------------------------------------------------------------------------------------------------
    Comment       { fg = C.bright.black },

    Constant      { Normal },
    String        { fg = C.normal.green },
    Character     { String },
    Number        { fg = C.normal.cyan },
    Boolean       { Number },

    Identifier    { Normal },
    -- Function     { fg = C.normal.blue },
    Function      { Normal },

    Statement     { Normal },
    Conditional   { fg = C.bright.white },
    Repeat        { Conditional },
    Label         { Conditional },
    Operator      { Normal },
    Keyword       { Normal },
    Exception     { fg = C.normal.red },

    PreProc       { Normal },
    -- Include         { },
    -- Define          { },
    -- Macro           { },
    -- PreCondit       { },

    Type           { Normal },
    -- StorageClass    { },
    -- Structure       { },
    -- Typedef         { },

    Special           { Normal },
    SpecialChar     { Number },
    -- Tag             { },
    Delimiter       { fg = C.bright.black },
    SpecialComment  { },
    -- Debug           { },

    ---------------------------------------------------------------------------------------------------------------------
    --- Diff & Git
    -------------------------------------------------------------------------------------------------------------------
    -- DiffAdd     { fg = C.normal.blue, bg = C.normal.blue.da(80) },
    -- DiffDelete  { fg = C.normal.yellow, bg = C.normal.yellow.da(80) },
    -- DiffChange  { bg = C.normal.yellow.da(55) },
    -- DiffText    { bg = C.normal.blue.da(50) },
    -- GitAdd      { fg = C.normal.blue },
    -- GitDelete   { fg = C.normal.yellow },
    -- GitChange   { fg = C.normal.yellow },
    -- GitNew      { fg = C.normal.blue },

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

    sym("@attribute")                   { fg = C.normal.blue }, -- attribute annotations (e.g. Python decorators, Rust lifetimes)
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

    sym("@keyword")                     { Keyword }, -- keywords not fitting into specific categories
    sym("@keyword.coroutine")           { Operator }, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
    sym("@keyword.function")            { Function }, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    sym("@keyword.operator")            { Operator }, -- operators that are English words (e.g. `and`, `or`)
    sym("@keyword.import")              { Keyword }, -- keywords for including modules (e.g. `import`, `from` in Python)
    sym("@keyword.type")                { Type }, -- keywords defining composite types (e.g. `struct`, `enum`)
    sym("@keyword.modifier")            { Keyword }, -- keywords defining type modifiers (e.g. `const`, `static`, `public`)
    sym("@keyword.repeat")              { Repeat }, -- keywords related to loops (e.g. `for`, `while`)
    sym("@keyword.return")              { Operator }, -- keywords like `return` and `yield`
    sym("@keyword.debug")               { Operator }, -- keywords related to debugging
    sym("@keyword.exception")           { Error }, -- keywords related to exceptions (e.g. `throw`, `catch`)

    sym("@keyword.conditional")         { Conditional }, -- keywords related to conditionals (e.g. `if`, `else`)
    -- sym("@keyword.conditional.ternary") { }, -- ternary operator (e.g. `?`, `:`)

    -- sym("@keyword.directive")           { }, -- various preprocessor directives and shebangs
    -- sym("@keyword.directive.define")    { }, -- preprocessor definition directives

    -- sym("@punctuation.delimiter")       { }, -- delimiters (e.g. `;`, `.`, `,`)
    -- sym("@punctuation.bracket")         { }, -- brackets (e.g. `()`, `{}`, `[]`)
    sym("@punctuation.special")         { fg = C.normal.cyan }, -- special symbols (e.g. `{}` in string interpolation)

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

    -- sym("@diff.plus")                   { DiffAdd }, -- added text (for diff files)
    -- sym("@diff.minus")                  { DiffDelete }, -- deleted text (for diff files)
    -- sym("@diff.delta")                  { DiffChange }, -- changed text (for diff files)

    -- sym("@tag")                         { }, -- XML-style tag names (e.g. in XML, HTML, etc.)
    -- sym("@tag.builtin")                 { }, -- XML-style tag names (e.g. HTML5 tags)
    -- sym("@tag.attribute")               { }, -- XML-style tag attributes
    -- sym("@tag.delimiter")               { }, -- XML-style tag delimiters

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
    sym("@lsp.type.namespace")      { Normal }, -- Identifiers that declare or reference a namespace, module, or package
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
    --- Plugins
    -------------------------------------------------------------------------------------------------------------------
    -- TreesitterContext { bg = NormalFloat.bg },
    -- TreesitterContextLineNumber { LineNr },
    -- TreesitterContextSeparator { },
    -- TreesitterContextBottom { },
    -- TreesitterContextLineNumberBottom { },

    MatchParenCur { MatchParen },
    MatchWordCur { MatchParen },

    -- NeogitDiffAdd             { DiffAdd },
    -- NeogitDiffDelete          { DiffDelete },
    -- NeogitDiffChange          { DiffChange },
    -- NeogitDiffText            { DiffText },
    -- NeogitDiffAdditions       { DiffAdd },
    -- NeogitDiffDeletions       { DiffDelete },
    -- NeogitDiffAddLighlight    { DiffAdd },
    -- NeogitDiffDeleteHighlight { DiffDelete },
    -- NeogitDiffAddCursor       { GitAdd },
    -- NeogitDiffDeleteCursor    { DiffDelete },

    MiniIndentscopeSymbol { Delimiter },
  }
end)

return theme
-- vi:nowrap

---@type vim.lsp.Config
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "elm",
    "html",
    "php",
    "css",
    "scss",
    "javascript",
    "typescript",
  },
  root_markers = {
    "postcss.config.cjs",
    ".git",
  },
  init_options = {
    userLanguages = {
      elm = "html",
      html = "html",
    },
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        elm = "html",
        html = "html",
      },
      classAttributes = { "class", "className", "classList", "ngClass" },
      experimental = {
        classRegex = {
          '\\bclass[\\s(<|]+"([^"]*)"',
          '\\bclass[\\s(]+"[^"]*"[\\s+]+"([^"]*)"',
          '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
          '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
          '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
          '\\bclassList[\\s\\[\\(]+"([^"]*)"',
          '\\bclassList[\\s\\[\\(]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"([^"]*)"',
          '\\bclassList[\\s\\[\\(]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"([^"]*)"',
        },
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}

local g = require("galaxyline")
local gs = g.section

gs.left[1] = {
    FileName = {
        provider = "FileName",
        condition = function()
            if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                return true
            end
            return false
        end,
        highlight = "WildMenu"
    }
}

gs.left[2] = {
    GitBranch = {
        provider = "GitBranch",
        condition = function()
            if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                return true
            end
            return false
        end,
        icon = "b:",
        highlight = "StatusLine"
    }
}

gs.mid[1] = {
    GetLspClient = {
        provider = "GetLspClient",
        highlight = "StatusLine"
    }
}

-- gs.mid[2] = {
--     DiagnosticError = {
--         provider = "DiagnosticError",
--         highlight = "ErrorText"
--     }
-- }

gs.right[2] = {
    ScrollBar = {
        provider = "ScrollBar",
        condition = function()
            if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                return true
            end
            return false
        end,
        highlight = "WildMenu"
    }
}

gs.right[1] = {
    LineColumn = {
        provider = "LineColumn",
        condition = function()
            if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                return true
            end
            return false
        end,
        highlight = "StatusLine"
    }
}

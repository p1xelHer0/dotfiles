-- we only ever have tabs in Go files: hide them
-- stylua: ignore start
vim.opt.listchars = {
  eol             = " " ,
  tab             = "  ",
  trail           = "·" ,
  extends         = "→" ,
  precedes        = "←" ,
  nbsp            = "␣" ,
}
-- stylua: ignore end

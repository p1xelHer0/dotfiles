local O = require("p1xelHer0.config").options()

vim.filetype.add({
  extension = {
    hlsl = "hlsl",
    hlsli = "hlsl",
  },
})

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf].filetype ~= "bigfile" and path and vim.fn.getfsize(path) > O.bigfile_size and "bigfile"
          or nil
      end,
    },
  },
})

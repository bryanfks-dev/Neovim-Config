local api = vim.api
local bo = vim.bo
local g = vim.g

g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- Vue extension
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.vue",
  callback = function()
    bo.filetype = "vue"
  end
})

-- Dart extension
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.dart",
  callback = function()
    bo.filetype = "dart"
  end
})


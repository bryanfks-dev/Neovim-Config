return {
  "rebelot/kanagawa.nvim",
  config = function()
    require('kanagawa').setup({
      compiled = true
    });
    vim.cmd("colorscheme kanagawa");
  end,
  build = function()
    vim.cmd("KanagawaCompile");
  end,
}

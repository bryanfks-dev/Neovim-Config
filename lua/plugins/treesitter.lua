return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local nvim_treesitter = require("nvim-treesitter.configs")

      nvim_treesitter.setup({
        highlight = { enable = true },
        indent = { enable = true, disable = { "dart" } },
        auto_install = true,
        sync_install = true,
        ensure_installed = {
          "lua", 
          "go",
          "javascript",
          "typescript",
          "vue",
          "html",
          "css",
          "json",
          "markdown",
          "python",
          "java",
          "css",
          "c",
          "cpp"
        },
      })
    end,
  },
}

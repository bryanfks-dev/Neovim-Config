return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        vue = { "prettierd", "prettier" },
        react = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        python = { "black" },
        dart = { "dart_format" },
        go = { "gofmt" }
      },
      formatters = {
        command = "black",
        args = { "--fast", "-" },
        stdin = true,
      },
      format_on_save = false,
    })
  end,
}

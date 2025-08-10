return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "ruff" },
      go = { "golangci_lint" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      typescriptreactreact = { "eslint" },
      vue = { "eslint" },
      dart = { "dart_analyze" },
      -- add more here
    }

    lint.linters.dart_analyze = {
      cmd = "dart",
      stdin = false,
      args = { "analyze" },
      ignore_exitcode = true,
    }

    lint.linters.golangci_lint = {
      cmd = "golangci-lint",
      stdin = false,
      args = { "run", "--out-format", "json" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require('lint.parser').from_errorformat('%f:%l:%c: %m', {
        source = 'golangci-lint',
        severity = vim.diagnostic.severity.WARN,
      })
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}

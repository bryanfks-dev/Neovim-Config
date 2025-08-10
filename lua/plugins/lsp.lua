return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "artemave/workspace-diagnostics.nvim",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          }
        },
        ts_ls = {
          on_attach = function(client, _)
            require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
          end,
        },
        eslint = {},
        gopls = {},
        pyright = {},
        vue_ls = {
          filetypes = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "json",
          },
        },
        tailwindcss = {},
        jedi_language_server = {},
        dartls = {}
      },
    },
    config = function(_, opts)
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local nvim_lspconfig = require("lspconfig")
      local lsp = vim.lsp

      mason.setup()

      -- LSP list
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "eslint",
          "gopls",
          "vue_ls",
          "tailwindcss",
        },
      })

      lsp.enable('dartls')
      nvim_lspconfig.dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        init_options = {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
        root_markers = { "pubspec.yaml" },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      })
   end,
  },
}

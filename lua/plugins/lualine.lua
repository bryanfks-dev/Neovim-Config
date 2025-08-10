return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      local lualine = require("lualine")

      lualine.setup({
        options = {
          theme = "palenight",
        },
        sections = {
          lualine_c = { {
            "filename",
            path = 1,
          } },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_x = { "filetype" },
          lualine_y = {
            {
              "diagnostics",
              sources = { "nvim_workspace_diagnostic" },
            },
          },
          lualine_z = {},
        },
      })
    end,
  },
}

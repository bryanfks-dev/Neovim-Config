return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      highlight = "IblIndent",
      char = "│",
    }
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    highlight = "IblScope",
  },
  exclude = {
    filetypes = {
      "help",
      "terminal",
      "dashboard",
      "lazy",
      "NvimTree",
      "Trouble",
    },
    buftypes = { "terminal", "nofile" },
  }
}

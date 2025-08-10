return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      "<leader>ff", "<cmd>Telescope find_files<CR>",
      "<leader>fg", "<cmd>Telescope live_grep<CR>",
    },
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  }
}

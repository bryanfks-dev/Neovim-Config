return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>b", ":Neotree toggle<CR>" },
    { "<leader>t", ":Neotree focus<CR>" },
  },
  lazy = false,
  opts = {
    filesystem = {
      async_directory_scan = true,
      scan_mode = "shallow",
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = { "node_modules", ".git", ".cache", ".DS_Store", ".idea" },
      }
    },
    window = {
      mappings = {
        ["t"] = "open_tabnew",
        ["s"] = "open_split"
      }
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_get_option(buf, "modified")
              and vim.api.nvim_buf_get_option(buf, "modifiable")
              and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
              vim.api.nvim_buf_call(buf, function()
                vim.cmd("silent! write")
              end
              )
            end
          end
        end
      }
    }
  },
  config = function(_, opts)
    local neo_tree = require("neo-tree")

    neo_tree.setup(opts)

    if vim.fn.argc() == 0 then
      vim.cmd("Neotree")
    end
  end,
}

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      debug_mode                   = false,
      signs_staged_enable          = true,
      numhl                        = false,
      linehl                       = false,
      word_diff                    = false,
      auto_attach                  = true,
      attach_to_untracked          = true,
      current_line_blame           = true,
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil,
      max_file_length              = 100000,
      preview_config               = {
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    })
  end
}

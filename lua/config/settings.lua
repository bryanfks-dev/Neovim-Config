local opt = vim.opt
local api = vim.api
local diagnostic = vim.diagnostic
local g = vim.g
local o = vim.o
local cmd = vim.cmd
local defer_fn = vim.defer_fn

-- Set the leader key
g.mapleader = " "
g.maplocalleader = " "

-- Show line number and relative line number
opt.number = true
opt.relativenumber = true

-- Enable cursor line on highlight
opt.cursorline = true

-- Show window title
opt.title = true

-- Keep n lines above and below the cursor
opt.scrolloff = 10

-- Number of spaces a tab represents
opt.tabstop = 2
opt.softtabstop = 2

-- Use appropriate number of spaces for indentation
opt.expandtab = true
opt.shiftwidth = 2

-- Auto indent new lines to the same level as the
-- previous line
opt.autoindent = true

-- Indent corretly after brackets
opt.smartindent = true
opt.indentexpr = "GetSmartIndent()"

-- Faster scrolling
opt.lazyredraw = true

-- Show line numbers
opt.showtabline = 3

-- Better search
opt.ignorecase = true
opt.smartcase = true

-- Highlight search results
opt.incsearch = true

-- Wrap long lines
opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.showbreak = string.rep(" ", 3)

-- Limit the width of the text in the window
opt.textwidth = 100

-- Enable syntax highlighting
opt.modelines = 1
opt.syntax = "on"

-- Disable spell checking
opt.spell = false

-- Disable showing the mode below the statusline
opt.showmode = false

-- Show the git signs symbol in the column
opt.signcolumn = "yes"

-- Auto insert comment leader when starting a new line
-- if the line above is a comment
opt.formatoptions:append({ "r", "o" })

-- Set the file format to unix
opt.fileformat = "unix"

-- Hide the "invisible characters" in the buffer
-- including the `^M` char.
opt.list = false

-- Show the ruler on the workspace
opt.ruler = true
opt.colorcolumn = "100"

-- Show inline error
diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
})

-- Set the fold method to expression using the treesitter fold
-- expression
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Enable folding code
opt.foldenable = true

-- Disable folding on startup
opt.foldlevelstart = 99

-- Default terminal program
-- Adjust this with your operating system and terminal emulator
o.shell = "powershell.exe"

-- Auto show neo tree on tab enter
api.nvim_create_autocmd("TabNew", {
  callback = function()
    -- Delay is needed because new tabs may not be ready immediately
    defer_fn(function()
      -- Only open Neo-tree if it's not already open in the current
      -- tab
      local neo_tree_open = false
      for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
        local bufname = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
        if bufname:match("neo%-tree filesystem") then
          neo_tree_open = true
          break
        end
      end

      if not neo_tree_open then
        cmd("Neotree show left")
      end
    end, 10)
  end
})


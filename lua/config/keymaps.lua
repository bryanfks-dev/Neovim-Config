local api = vim.api
local keymap = vim.keymap
local fn = vim.fn
local cmd = vim.cmd
local bo = vim.bo
local lsp = vim.lsp
local diagnostic = vim.diagnostic

-------------------------------------------------
-- Normal mode
-------------------------------------------------
-- Disable space, because it's the leader key
keymap.set('n', "<leader>", "<nop>")

-- Save and quit current file quicker
keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false })

-- Move lines up and down
keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true })
keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true })

-- Find and replace across files
keymap.set('n', '<leader>ra', function()
  -- Promt user for search and replace keyword
  local old_keyword = fn.input("Find keyword to replace: ")

  -- Validate search keyword
  if old_keyword == "" then
    print("No keyword provided. Exit.")
    return
  end

  local new_word = fn.input("Replace with: ")

  -- Find all matching files using ripgrep
  local grep_cmd = string.format("rg --files-with-matches '%s'", old_keyword)
  local files = fn.systemlist(grep_cmd)

  -- Check if any files were found with the keyword
  if #files == 0 then
    print(string.format("No files found with the keyword: '%s'", old_keyword))
    return
  end

  -- Set the file list to args
  cmd("args " .. table.concat(files, " "))

  -- Perform the replacement in all matched files
  cmd(string.format("argdo %%s/%s/%s/ge | update", old_keyword, new_word))

  print("Replaced all instances of '" .. old_keyword .. "' with '" .. new_word .. "' in " .. #files .. " files.")
end)

-- Move cursor to Neotree
api.nvim_set_keymap('n', '<leader>t', ':Neotree reveal<CR>', { noremap = true, silent = true })

-- Toggle Neotree visibility
api.nvim_set_keymap('n', '<leader>b', ':Neotree toggle<CR>', { noremap = true, silent = true })

-------------------------------------------------
-- Insert mode
-------------------------------------------------
-- Auto complete brackets
api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true })
api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true })
api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true })
api.nvim_set_keymap('i', "'", "''<Left>", { noremap = true })
api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true })

-- Auto create new line with indent when pressing Enter
-- inside the brackets
keymap.set('i', '<CR>', function()
  local col = fn.col('.')
  local line = fn.getline('.')
  local prev = line:sub(col - 1, col - 1)
  local next = line:sub(col, col)

  -- Check if cursor is between a matching pair of brackets
  local pairs = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['<'] = '>',
  }

  if pairs[prev] == next then
    return '<CR><Esc>O'
  end

  return '<CR>'
end, { expr = true, noremap = true })

-------------------------------------------------
-- Visual mode
-------------------------------------------------
-- Disable space, because it's the leader key
keymap.set('v', "<leader>", "<nop>", { noremap = true })

-- Move selection up and down
keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

-------------------------------------------------
-- Misc
-------------------------------------------------
-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- LSP keymaps
api.nvim_create_autocmd("LspAttach", {
  -- Use LspAttach autocommand to only map the following keys after
  -- the language server attaches to the current buffer
  group = api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
    keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap.set("n", "gr", vim.lsp.buf.references, opts)

    keymap.set("n", "<leader>f", function()
      lsp.buf.format({ async = true })
    end, opts)

    -- Use the conform.nvim plugin to format the current buffer
    keymap.set({ "n", "v" }, "<leader>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, opts)

    -- Open the diagnostic under the cursor in a float window
    keymap.set("n", "<leader>d", function()
      diagnostic.open_float({
        border = "rounded",
      })
    end, opts)
  end,
})

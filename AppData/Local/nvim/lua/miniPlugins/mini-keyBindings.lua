-- mini_ai_keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- doens't work as of now Welp

-- Custom text object 'c' for call expressions (like require(...) or fetch(...))
map("n", "vac", "<cmd>lua MiniAi.select_textobject('a', 'c', 'c')<CR>", opts)
map("n", "sic", "<cmd>lua MiniAi.select_textobject('i', 'c', 'c')<CR>", opts)

-- Add any other mini.ai mappings here

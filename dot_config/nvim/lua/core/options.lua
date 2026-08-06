-- ~/.config/nvim/lua/core/options.lua
-- print("✅ Loaded core/options.lua")
-- vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.cursorline = true

-- vim.opt.nu = true                 -- Show line numbers
-- vim.opt.relativenumber = true    -- Use relative numbers (except current line)
-- vim.o.statuscolumn = "%s %l %r " -- Define custom layout for the gutter

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Vertical Line
-- local opt = vim.opt
-- opt.cursorline = true
-- opt.cursorcolumn = true

-- vim.api.nvim_command("highlight CursorLine guibg=#2D313B")
-- vim.api.nvim_command("highlight CursorColumn guibg=#2D313B")

local comment_fg = vim.api.nvim_get_hl_by_name("Comment", true).foreground
vim.api.nvim_set_hl(0, "Comment", { fg = comment_fg, italic = true })

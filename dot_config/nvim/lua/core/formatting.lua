-- For Formatters like indentation
vim.opt.tabstop = 8 -- number of visual spaces per TAB
vim.opt.softtabstop = 8 -- number of spaces when hitting TAB in insert mode
vim.opt.shiftwidth = 8 -- number of spaces for autoindent
vim.opt.expandtab = false -- use actual TAB characters

-- Emojis
vim.api.nvim_set_hl(0, "KeymapEmoji", {
	fg = "NONE",
	bg = "NONE",
})

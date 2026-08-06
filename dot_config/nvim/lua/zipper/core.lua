-- zipper/core.lua
local float = require("zipper.float")

local M = {}

local function run()
	local cwd = vim.fn.getcwd()
	local files = vim.fn.readdir(cwd)
	local result = float.open(files)
	local win_id = result.win
	local buf_if = result.buf
	print("Hello")

	vim.api.nvim_win_close(win_id, true)
end

M.run = run
return M

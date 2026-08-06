-- zipper/float.lua
print("╔══════════════════════════════╗")
print("║    zipper/float.lua RELOADED ║")
print("╚══════════════════════════════╝")
local M = {}

local win_id, buf_id
local function show(lines)
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.notify("it already exists")
		vim.api.nvim_win_close(win_id, true)
	end
	print("hello bro yo")

	buf_id = vim.api.nvim_create_buf(false, true)
	print(buf_id)

	local header = {
		" [Z] Zip All   [E] Exclude   [M] Mark All",
		string.rep("─", 40),
	}
	local lines = vim.list_extend(header, lines)

	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)

	win_id = vim.api.nvim_open_win(buf_id, true, {
		relative = "editor",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		style = "minimal",
		border = "rounded",
	})
	print(win_id)

	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
	vim.api.nvim_buf_add_highlight(buf_id, -1, "String", 0, 0, -1)

	-- Set buffer-local keymap for 'q' to close the buffer
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win_id, true)
	end, { buffer = buf_id, silent = true })

	-- Check if window is still valid
	print("Window valid:", win_id and vim.api.nvim_win_is_valid(win_id))
	-- Check if buffer is still valid
	print("Buffer valid:", buf_id and vim.api.nvim_buf_is_valid(buf_id))

	return { buf = buf_id, win = win_id }
end

M.open = show

return M

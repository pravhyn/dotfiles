local M = {}

function M.get_config_path()
	local is_termux = vim.g.is_termux or _G.is_termux
	local path = ""

	if is_termux then
		-- Termux: ~/.config/nvim/lua/plugins/init.lua
		path = os.getenv("HOME") .. "/.config/nvim/lua/plugins/init.lua"
	else
		-- Windows path
		path = "C:\\Users\\prave\\AppData\\Local\\nvim\\lua\\plugins\\lazy-init.lua"
	end

	if vim.fn.filereadable(path) == 1 then
		return path
	else
		return nil
	end
end

return M


return {
	{
		"bfredl/nvim-luadev",
		ft = "lua", -- optional: load only for Lua files
		config = function()
			vim.keymap.set("n", "<leader>ld", ":Luadev<CR>", { desc = "Open LuaDev REPL" })
		end,
	},
	{
		"kikito/inspect.lua",
		name = "inspect",
		lazy = true,
	},
	{
		"rafcamlet/nvim-luapad",
		ft = "lua", -- optional: load only for Lua files
		config = function()
			require("luapad").setup({
				count_limit = 150000,
				error_indicator = true,
				eval_on_change = true,
				eval_on_move = false,
				preview = true,
				split_orientation = "horizontal",
				context = {
					the_answer = 42,
					shout = function(str)
						return (string.upper(str) .. "!")
					end,
				},
			})
			vim.keymap.set("n", "<leader>lp", ":Luapad<CR>", { desc = "Open Luapad scratchpad" })
			vim.keymap.set("n", "<leader>lr", ":LuaRun<CR>", { desc = "Run buffer as Lua script" })
		end,
	},
	{
		"0x100101/lab.nvim",
		build = "cd js && npm install",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("lab").setup()
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
}

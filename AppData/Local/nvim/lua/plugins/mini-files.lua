return {
	"echasnovski/mini.files",
	version = false, -- always use latest
	config = function()
		require("mini.files").setup({
			windows = {
				preview = true, -- enables preview window
				width_focus = 30,
				width_preview = 40,
			},
			options = {
				use_as_default_explorer = false, -- avoids hijacking netrw
			},
		})

		-- Optional: Keymap to open mini.files in current directory
		vim.keymap.set("n", "<leader>fm", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		end, { desc = "Open MiniFiles in current buffer's directory" })
	end,
}

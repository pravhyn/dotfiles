return {
    "akinsho/toggleterm.nvim",
    version = "*",

    config = function()

        require("toggleterm").setup {
            size = 15,
            open_mapping = [[<c-\>]],
            autochdir = true,
            start_in_insert = true, -- Start in insert mode
            shade_terminals = true,
            persist_size = true,
			direction = "float",

        }

    end

}

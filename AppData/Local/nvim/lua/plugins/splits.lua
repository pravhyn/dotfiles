return {
        "hiattp/splitwise.nvim",
        commit = "658a1c29575e2f2c27e86a56867f983edeb2795e",

        event = "VeryLazy", -- or "BufReadPost" if you want it earlier
        config = function()
                require("splitwise").setup({
                        create_default_keymaps = false,
                })
                vim.keymap.set("n", "<C-H>", require("splitwise").move_left, { desc = "Splitwise left" })
                vim.keymap.set("n", "<C-L>", require("splitwise").move_right, { desc = "Splitwise right" })
        end,
}

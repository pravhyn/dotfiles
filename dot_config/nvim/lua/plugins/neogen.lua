return {
        "danymat/neogen",
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*",
        config = function()
                require("neogen").setup({
                        enabled = true,
                        -- languages = {
                        --   typescript = {
                        --     template = {
                        --       annotation_convention = "jsdoc"
                        --     }
                        --   }
                        -- }
                })

                local opts = { noremap = true, silent = true }
                vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
        end,
}

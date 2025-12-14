return {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
                require("nvim-treesitter.configs").setup({
                        ensure_installed = { "lua", "python", "javascript", "typescript", "bash", "latex" }, -- Add or remove languages as needed
                        highlight = {
                                enable = true, -- Syntax highlighting
                        },
                        indent = {
                                enable = true, -- Smarter indentation
                        },
                        textobject = {
                                select = {
                                        enable = true,
                                        lookahead = true,
                                        keymaps = {
                                                ["ak"] = "@assignment.outer",
                                                ["ik"] = "assignment.inner",
                                        },
                                },
                        },
                })
        end,
}

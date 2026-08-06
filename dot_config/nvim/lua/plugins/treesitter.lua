return {
        {
                "nvim-treesitter/nvim-treesitter",
                lazy = false,
                build = ":TSUpdate",
                config = function()
                        local ts = require("nvim-treesitter")
                        ts.install({
                                "rust",
                                "javascript",
                                "lua",
                                "python",
                                "latex",
                                "typescript",
                                "bash",
                        })
                end,
        },
}
-- return {
--
--         "nvim-treesitter/nvim-treesitter",
--         -- branch = "main", -- New Line
--         lazy = false,
--         build = ":TSUpdate",
--         -- main = "nvim-treesitter.configs",
--         config = function()
--                 require("nvim-treesitter.configs").setup({
--                         ensure_installed = { "lua", "python", "javascript", "typescript", "bash", "latex" }, -- Add or remove languages as needed
--                         highlight = {
--                                 enable = true, -- Syntax highlighting
--                         },
--                         indent = {
--                                 enable = true, -- Smarter indentation
--                         },
--                         textobjects = {
--                                 select = {
--                                         enable = true,
--                                         lookahead = true,
--                                         keymaps = {
--                                                 ["ak"] = "@assignment.outer",
--                                                 ["ik"] = "@assignment.inner",
--                                         },
--                                 },
--                         },
--                 })
--         end,
-- }

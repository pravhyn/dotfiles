vim.g.neotest_log_level = "debug"
return {
        "nvim-neotest/neotest",
        dependencies = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",
                "nvim-neotest/neotest-jest",
        },
        config = function()
                require("neotest").setup({
                        discovery = {
                                enabled = false,
                        },
                        adapters = {
                                require("neotest-jest")({
                                        jestCommand = "npm test --",
                                        cwd = function()
                                                return vim.fn.getcwd()
                                        end,
                                }),
                        },
                })
        end,
}

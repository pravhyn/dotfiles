return {
        {
                "stevearc/conform.nvim",
                opts = {
                        formatters_by_ft = {
                                lua = { "stylua" },
                                python = { "isort", "black" },
                                rust = { "rustfmt", lsp_format = "fallback" },
                                javascript = { "prettierd", "prettier", stop_after_first = true },
                        },
                        format_on_save = {
                                -- I recommend these options. See :help conform.format for details.
                                lsp_format = "fallback",
                                timeout_ms = 1000,
                        },
                        formatters = {
                                stylua = {
                                        prepend_args = { "--indent-width", "8", "--indent-type", "Spaces" },
                                },
                                prettier = {
                                        prepend_args = { "--tab-width", "8", "--use-tabs", "false" },
                                },
                                shfmt = {
                                        prepend_args = { "-i", "8" },
                                },

                                black = {
                                        prepend_args = { "--fast" }, -- optional, speeds up
                                        timeout_ms = 10000, -- increase timeout to 10s
                                },
                        },
                },
        },
        {
                "nmac427/guess-indent.nvim",
                opts = {},
                event = { "BufReadPre", "BufNewFile" },
        },
}

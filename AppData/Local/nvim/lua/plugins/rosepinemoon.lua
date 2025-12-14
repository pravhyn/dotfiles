return {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000, -- Load early to apply colors before plugins
        lazy = false,
        config = function()
                require("rose-pine").setup({
                        variant = "moon", -- Options: "auto", "main", "moon", "dawn"
                        dark_variant = "moon",
                        dim_inactive_windows = true,
                        extend_background_behind_borders = true,

                        styles = {
                                bold = true,
                                italic = false,
                                transparency = true, -- set to true if using a transparent terminal
                        },
                })

                vim.cmd("colorscheme rose-pine")
        end,
        -- { "rebelot/kanagawa.nvim" },
}

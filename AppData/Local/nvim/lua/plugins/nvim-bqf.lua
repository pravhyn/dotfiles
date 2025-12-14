return {
        -- nvim-bqf: Floating preview and enhancements for quickfix
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
                preview = {
                        auto_preview = true,
                        border_chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
                func_map = {
                        open = "<CR>",
                        drop = "o",
                        split = "<C-s>",
                        tabdrop = "<C-t>",
                        toggle_preview = "P",
                },
        },
}

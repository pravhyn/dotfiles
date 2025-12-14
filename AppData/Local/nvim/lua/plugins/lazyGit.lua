return {
        "kdheepak/lazygit.nvim",
        lazy = true,
        dependencies = {
                "nvim-lua/plenary.nvim", -- Required dependency
        },
        keys = {
                { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
                { "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "Open LazyGit Config" },
                { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "Open LazyGit (File)" },
                { "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "Open LazyGit (Current File)" },
        },
        -- config = function()
        --   require("lazygit").setup({
        --     floating_window_scaling_factor = 0.9, -- Adjust window size (0.1 to 1.0)
        --     floating_window_use_plenary = true,   -- Use plenary.nvim for better performance
        --     use_neovim_remote = false,           -- Set to `true` if you use `neovim-remote`
        --     lazygit_floating_window_winblend = 10, -- Transparency (0-100)
        --     lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border style
        --   })
        -- end,
}

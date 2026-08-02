return {
        "nvim-lualine/lualine.nvim",
        enabled = not _G.is_termux,
        config = function()
                -- print("[Lualine] Loaded (is_termux: " .. tostring(_G.is_termux) .. ")")
                require("core.lualine").setup()
        end,
}

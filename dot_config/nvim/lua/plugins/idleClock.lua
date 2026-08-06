return {
        "praveenscript/idleClock.nvim",
        config = function()
                require("idleClock").setup({
                        idleTimeLimit = 30,
                })
        end,
}

return {
  "echasnovski/mini.statusline",
  config = function()
    if _G.is_termux then
    --   print("[MiniStatusline] Activated in Termux")
      require("mini.statusline").setup({ use_icons = false })
    else
    --   print("[MiniStatusline] Skipped on Desktop")
    end
  end,
}
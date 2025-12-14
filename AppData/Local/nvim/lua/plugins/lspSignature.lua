-- This is ugly, I thought of adding a toggle where it'll only when I toggle but somehow it force
-- insert itself in insert mode; I'll try to fix this
return {

  "ray-x/lsp_signature.nvim",
  config = function()
    local signature = require("lsp_signature")

    -- Setup with everything disabled for insert mode
    signature.setup({
      bind = false,              -- disables auto popup
      hint_enable = false,       -- disables inline hints
      floating_window = true,    -- allows manual float
      toggle_key = nil,          -- disables internal keymap
      handler_opts = {
        border = "rounded",
      },
    })

    -- Manual trigger: only works in normal mode
    vim.keymap.set("n", "<leader>hr", function()
      signature.toggle_float_win()
    end, { desc = "Show Signature Help (Manual)" })
  end,
}
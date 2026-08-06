return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
  mode = "buffers",
  diagnostics = "nvim_lsp",
  indicator = { style = "icon" }, -- or "none" if you want pure minimalism
  separator_style = "thin",       -- "thin" gives a crisp divider
  show_buffer_icons = false,      -- remove devicons for a cleaner look
  show_buffer_close_icons = false,
  always_show_bufferline = true,
  enforce_regular_tabs = true,    -- uniform spacing
}
,
    })
  end,
}

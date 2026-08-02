return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  enabled = not _G.is_termux,
  config = function()
    require("diffview").setup({
      use_icons = false, -- safe for Termux fonts; toggle to true on desktop
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal", -- can be diff2_vertical, diff3_horizontal, etc.
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
      },
      file_panel = {
        listing_style = "tree",
        win_config = { position = "left", width = 35 },
      },
      file_history_panel = {
        log_options = {
          single_file = {
            diff_merges = "combined",
          },
          multi_file = {
            diff_merges = "first-parent",
          },
        },
      },
      hooks = {},
    })
  end,
}
return {
  "m4xshen/autoclose.nvim",
  event = "InsertEnter",
  config = function()
    require("autoclose").setup({
      -- Default config, but you can customize pairs, escape behavior, etc.
      keys = {
        -- Add a custom pair: dollar signs for markdown/LaTeX
        -- ["$"] = {
        --   escape = true,
        --   close = true,
        --   pair = "$$",
        -- },
        -- Or override built-ins, like disabling single quotes
        ["'"] = {
          escape = false,
          close = false,
        },
      },
      options = {
        disabled_filetypes = { "fzf", "neo-tree", "lazy" },
      },
    })
  end,
}
return{
  "folke/persistence.nvim",
  event = "BufReadPre", -- load early to catch sessions
  opts = {
    options = { "buffers", "curdir", "tabpages", "winsize" },
    pre_save = function()
      return vim.bo.filetype ~= "gitcommit" -- skip saving during commits
    end,
  },
  keys = {
    {
      "<leader>qs",
      function() require("persistence").load() end,
      desc = "Restore last session"
    },
    {
      "<leader>ql",
      function() require("persistence").load({ last = true }) end,
      desc = "Restore most recent session"
    },
    {
      "<leader>qd",
      function() require("persistence").stop() end,
      desc = "Don't save session for this buffer"
    },
  },
} 
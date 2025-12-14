return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    opts = {
      enable_close = true,         -- Auto close tags
      enable_rename = true,        -- Auto rename paired tags
      enable_close_on_slash = false, -- Optional: auto close on trailing </
    },
    -- Optional: override behavior per filetype
    per_filetype = {
      html = { enable_close = false }, -- Example override
    },
  },
}
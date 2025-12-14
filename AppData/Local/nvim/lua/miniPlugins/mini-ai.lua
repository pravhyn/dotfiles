return {
  'echasnovski/mini.ai',
  version = '*',
  lazy = false, -- or true if you prefer lazy loading
  config = function()
    require('mini.ai').setup()
  end,
}


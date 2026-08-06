return {
  'stevearc/oil.nvim',
  dependencies = { 'mini.icons/nvim-web-devicons' }, -- icon support
  lazy = false, -- recommended to keep eager
  opts = {
    view_options = {
      show_hidden = true, -- ✨ show dotfiles like .env, .gitignore etc.
    },
  },
    config = function()
      require('oil').setup()
      require('myoil.replaceBuffer')
      require('myoil.keymaps')
    end,

}
return{
  'rmagatti/alternate-toggler',
  lazy = false, -- or true if you want to load on demand
  config = function()
    require('alternate-toggler').setup {
      alternates = {
        ['true'] = 'false',
        ['false'] = 'true',
        ['=='] = '!=',
        ['==='] = '!==',
        ['Yes'] = 'No',
        ['enable'] = 'disable',
      },
    }

    -- Optional keymap to toggle under cursor
    vim.keymap.set('n', '<leader>ta', function()
      require('alternate-toggler').toggleAlternate()
    end, { desc = 'Toggle alternate value' })
  end,
} 
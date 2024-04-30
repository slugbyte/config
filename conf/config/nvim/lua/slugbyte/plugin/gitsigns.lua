-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  Lazy = false,
  opts = {
    signs = {
      add = { text = '|' },
      change = { text = '|' },
      delete = { text = '|' },
      topdelete = { text = '|' },
      changedelete = { text = '|' },
    },
  },
}

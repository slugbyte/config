require('telescope').setup({
  pickers = {
    find_files = {
      find_command = {
        'find_files'
      },
    },
  },
  defaults = {
    layout_strategy = 'flex',
    layout_config = { height = 0.7 },
    mappings = {
      i = {
        -- ["<C-u>"] = "which_key",
      }
    }
  },
})

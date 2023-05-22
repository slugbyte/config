local wet_lualine = require ('wet').lualine

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = wet_lualine,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode' },
    lualine_b = {{
      'filename',
      path = 1,
      file_status = true,
      symbols = {
        modified = ' [+]',
        readonly = ' [readonly]',
        unnamed = '[no name]',
      },
    }},
    lualine_c = {},
    lualine_x = { 'branch', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location', 'diagnostics' },
  }
}


-- personal colorscheme
return {
  'slugbyte/wet-nvim',
  enable = true,
  lazy = false,
  config = function()
    vim.cmd("colorscheme wet")
  end,
}


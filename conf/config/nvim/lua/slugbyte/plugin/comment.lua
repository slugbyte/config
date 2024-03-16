-- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
-- https://github.com/numToStr/Comment.nvim

return {
  'numToStr/Comment.nvim',
  event = 'VimEnter',
  dependencies = {
    {
      'folke/todo-comments.nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = { signs = false }
    },
  },
}

return {
  'christoomey/vim-tmux-navigator',
  event = 'VimEnter',
  config = function()
    -- vim.keymap.set('n', '<C-n>', ":TmuxNavigateDown<CR>", { silent = true, desc = "goto pane below (vim/tmux)" })
    -- vim.keymap.set('n', '<C-e>', ":TmuxNavigateUp<CR>", { silent = true, desc = "goto pane above (vim/tmux)" })
    -- vim.keymap.set('n', '<C-o>', ":TmuxNavigateRight<CR>", { silent = true, desc = "goto pane right (vim/tmux)" })
    -- vim.keymap.set('n', '<C-y>', ":TmuxNavigateLeft<CR>", { silent = true, desc = "goto pane left (vim/tmux)" })
  end,
}

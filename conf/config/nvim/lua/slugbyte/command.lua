local telescope_builtin = require('telescope.builtin')
function Edit_Config()
  telescope_builtin.find_files({
    cwd = '~/.config/nvim',
    follow = true,
    hidden = true,
  })
end
vim.cmd('command! EditConfig :lua Edit_Config()')

function Highlight_Toggle()
  if vim.o.hlsearch then
    print("[highlight off]")
    vim.o.hlsearch = false
  else
    print("[highlight on]")
    vim.o.hlsearch = true
  end
end
vim.cmd('command! HighlightToggle :lua Highlight_Toggle()')

function Ignorecase_Toggle ()
  if vim.o.ignorecase then
    print("[ignorecase off]")
    vim.o.ignorecase = false
  else
    print("[ignorecase on]")
    vim.o.ignorecase = true
  end
end
vim.cmd('command! IgnorecaseToggle :lua Ignorecase_Toggle()')

function Pastemode_Toggle()
  if vim.o.paste then
    print("[paste off]")
    vim.o.paste = false
    vim.o.ruler = false
  else
    vim.o.paste = true
    vim.o.ruler = true
    print("[paste on]")
  end
end
vim.cmd('command! PastemodeToggle :lua Pastemode_Toggle()')

vim.cmd('command! TrimLines :%s/\\s\\+$//e|norm!`` ')
vim.cmd('command! Reload :luafile ~/.config/nvim/init.lua')

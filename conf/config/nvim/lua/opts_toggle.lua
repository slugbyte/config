function Highlight_Toggle()
  if vim.o.hlsearch then
    print("highlight off")
    vim.o.hlsearch = false
  else
    print("highlight on")
    vim.o.hlsearch = true
  end
end
vim.cmd('command! HighlightToggle :lua Highlight_Toggle()')

function Ignorecase_Toggle ()
  if vim.o.ignorecase then
    print("ignorecase off")
    vim.o.ignorecase = false
  else
    print("ignorecase on")
    vim.o.ignorecase = true
  end
end
vim.cmd('command! IgnorecaseToggle :lua Ignorecase_Toggle()')

function Pastemode_Toggle()
  if vim.o.paste then
    print("pastemode off")
    vim.o.paste = false
    vim.o.ruler = false
  else
    vim.o.paste = true
    vim.o.ruler = true
    print("pastemode on")
  end
end
vim.cmd('command! PastemodeToggle :lua Pastemode_Toggle()')

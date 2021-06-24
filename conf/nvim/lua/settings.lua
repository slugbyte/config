-- global options
local o = vim.o
local cmd = vim.cmd

cmd('syntax on')
-- cmd('colorscheme yuejiu')
cmd('filetype plugin on')

-- syntax enable              
-- colorscheme yuejiu
-- filetype plugin on         
o.ruler = true
o.swapfile = false
o.backup = false
o.number = true
o.relativenumber = true
o.mouse = 'a'
o.autoread = true
o.incsearch = true
o.tabstop = 2
o.expandtab = true
o.ignorecase = true
o.smartcase = true
o.cursorline = true
o.shiftwidth = 2
-- o.backspace = '<BS>'
o.scrolloff = 5
o.foldenable = false
o.laststatus = 2
o.foldnestmax = 4
o.encoding = 'utf8'
o.showbreak = "+++ "
o.foldmethod = 'indent'
o.completeopt = 'preview'
o.wildmode = 'list:longest'
o.wildmenu = true
o.colorcolumn = '80,85'
o.clipboard = 'unnamedplus'
o.wrap = false
o.undofile = true
o.undodir = '~/.local/slugbyte/nvim_undo'
o.hlsearch = false

o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
]]

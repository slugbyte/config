call plug#begin('~/.config/nvim/plug')
" LANG
Plug 'cespare/vim-toml'
Plug 'leafgarland/typescript-vim'

" UTIL
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-eunuch'
Plug 'mbbill/undotree'
Plug 'dkprice/vim-easygrep'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" " UI
" "Plug 'scrooloose/syntastic'
Plug 'git@github.com:slugbyte/yuejiu'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" " KEYMAP
Plug 'git@github.com:slugbyte/unruly-worker', {'branch': 'stage-3'}
"Plug 'scrooloose/nerdcommenter'
call plug#end()

"
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugin Settings
" Vim-Slime
" let g:slime_target="tmux"
" let g:slime_default_c

" EasyMotion_do_mapping
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_keys = "123456789"


map gt <Plug>(easymotion-overwin-f)
" nmap ga <Plug>(coc-codeaction-selected)
nmap gs gaaw
nmap ga 'w<cr>
map n gn
map e ge
map y gy
map o go

" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename'
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
  return filename
endfunction

highlight ExtraWhitespace ctermbg=238
match ExtraWhitespace /\s\+$/

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Settings
" syntax enable              "  turn on syntax highlighting
colorscheme yuejiu
filetype plugin on         "  allow plugins to be applied to specifc file types
set ruler                  "  show the cursor position in the status bar
set noswapfile             "  no more swap files
set nobackup               "  don't create backups before overwrite
set number relativenumber  "  hybrid relative number
set mouse=a                "  allow the mouse to interact with vim
set autoread               "  when you run checktime it will refresh the file
set incsearch              "  vim starts searching while typing search string
set tabstop=2              "  make \t appear to be two spaces wide
set expandtab              "  convert tab to spaces (unless a filetype plugin changes that)
set ignorecase             "  non-case sensitve serach
set smartcase              " ignorecase unless the search uses uppercase
set cursorline             "  highlight the line current cursor line
set shiftwidth=2           "  make vim indent functions apply or remove two spaces
set backspace=2            "  make backspace 
set scrolloff=5            "  when scrolling up keep 5 lines of code at the top of the screen
set nofoldenable           "  stop vim from folding indent levels when opening a file
set laststatus=2           "  show the status line
set foldnestmax=4          "  dont fold more than four levels deep
set encoding=utf8          "  treat all text as utf-8
set showbreak="+++ "       "  mark the lines that overflow screen width using +++
set foldmethod=indent      "  fold and unfold text based on indent level
set completeopt-=preview   "  stop plugins from adding a docs window on tab completion
set wildmode=list:longest  "  configure tab completion to list all matches when there is more than one
set wildmenu               "  enable tab completion in the command bar
set colorcolumn=80         "  enable a visible column on the 80th char -(see)->
set clipboard=unnamedplus  "  use tes system clipboard for copy and paste
set nowrap                 "  dont wrap lines around
set undofile               "  always keep an undo histroy
set undodir=~/.local/slugbyte/nvim_undo
set nohlsearch


let g:is_bash=1            "  treat .sh files as bash scripts

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Key Mappings
" double tap "i" to escape 
" imap II <Esc> TODO STOP USING II 
" L jumps to end of line
map Y $
" H jumps to beginning of line
map O ^
" Use the spacebar as the leader key
let mapleader = "\\"
" qq to requort Q to replay
"nnoremap Q @q


" vim-command-line key binding
cnoremap <C-A> <Home>
cnoremap <C-L> <S-Right>
cnoremap <C-H> <S-Left>

" move lines 
"nnoremap <leader>K mz:m-2<CR>`z==
"nnoremap <leader>J mz:m+<CR>`z==
"vnoremap <leader>K :m'<-2<CR>gv=`>my`<mzgv`yo`z
"vnoremap <leader>J :m'>+<CR>gv=`<my`>mzgv`yo`z
" window managment
" nmap <leader>s :sp<cr>
" nmap <leader>v :vs<cr>
" nmap <leader>o :on<cr>
" nmap <leader>d :hide<cr>
" nmap <leader>h :wincmd h<cr>
" nmap <leader>j :wincmd j<cr>
" nmap <leader>k :wincmd k<cr>
" nmap <leader>l :wincmd l<cr>
" nmap <leader>n :wincmd n<cr>
" nmap <leader>c :close<cr>
" nmap <leader>< :15 wincmd <<cr>
" nmap <leader>> :15 wincmd ><cr>
" nmap <leader>= :10 wincmd +<cr>
" nmap <leader>- :10 wincmd -<cr>


"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shorthand
" TODO: convert this to a snippet
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
"inoreabbrev <expr> #doc "<!DOCTYPE html>"

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Commands
" reload the ~/.vimrc
command! Reload source ~/.config/nvim/init.vim
" helpers
command! C :close
command! Replace %s/<c-r><c-w>/
command! Todo Lines todo
command! Jformat execute '%!python -m json.tool' |w

" Telescope shorthand
 command! F Telescope find_files find_command=rg,--ignore,--hidden,--files
 command! H Telescope grep_string
 command! G Telescope git_files
 command! B Telescope buffers
 command! S Telescope live_grep
 command! R Telescope registers


" Npm Lint
function! Nolf()
  silent exe "!npm run lint:fix"
  redraw!
  bufdo! checktime
endfunction
command! Nolf call Nolf()

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Functions
" M  will toggle the mouse between
" vim select and clipboard select
function! MouseModeToggle()
  if  &mouse == "a"
    " cilpboard select will also hide line numbers
    set norelativenumber
    set mouse=v nonumber
    echo "mouse mode clipboard"
  else
    " vim select will also show line numbers
    set mouse=a number
    echo "mouse mode vim"
  endif
endfunction
command! MM :call MouseModeToggle()

" Toggle case sensitive search
function! IgnoreCaseToggle()
  set ignorecase!
  if  &ignorecase == 0
    " turn ignore case off
    echo "ignorecase off"
  else
    " turn ignore case on
    echo "ignorecase on"
  endif
endfunction
command! IC call IgnoreCaseToggle()


" <C-p> will toggle pastemode
function! PasteModeToggle()
  if  &paste == 0
    set paste ruler
    echo "paste mode on"
  else
    set nopaste ruler
    echo "paste mode off"
  endif
endfunction
command! PT :call PasteModeToggle()

" <f5> will toggle relative number
function! RelativeNumberToggle()
  if &relativenumber == 0
    set number relativenumber
    echo "relative number on"
  else
    set norelativenumber
    echo "relative number off"
  endif
endfunction
command! RN :call RelativeNumberToggle()

command! HL set hlsearch!

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filetype Commands
au BufRead,BufNewFile *.md.txt set syntax=markdown
au BufRead,BufNewFile *.js.txt set syntax=javascript
au BufRead,BufNewFile *.html.txt set syntax=html
au BufRead,BufNewFile Dockerfile* set syntax=dockerfile
au BufRead,BufNewFile .env.* set syntax=sh

let g:syntastic_javascript_checkers=['eslint']

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% YANK To Clipboard
"nnoremap <expr> k (v:register ==# '"' ? '"+' : '')
"nnoremap <expr> kk (v:register ==# '"' ? '"+' : '') . 'yy'
"xnoremap <expr> k (v:register ==# '"' ? '"+' : '') . 'y'
"xnoremap <expr> K (v:register ==# '"' ? '"+' : '') . 'Y'

let g:fzf_default_command = 'rg --files'

source ~/.config/nvim/config/coc.vim


let g:gitgutter_map_keys = 0
let g:NERDCreateDefaultMappings = 0
"map gc <Plug>NERDCommenterToggle

lua << EOF
  local actions = require('telescope.actions')
  require('telescope').setup{
   defaults = {
     mappings = {
       i = {
         ["<C-h>"] = actions.select_vertical,
         ["<C-s>"] = actions.select_horizontal,
       },
       n = {
         ["<C-h>"] = actions.select_vertical,
         ["<C-s>"] = actions.select_horizontal,
       }
     },
     layout_strategy = "vertical",
     file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
     grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
     qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
     buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
   }
  }
EOF

autocmd FileType markdown setlocal wrap
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown setlocal linebreak
autocmd FileType markdown setlocal spell
autocmd FileType markdown map n gn
autocmd FileType markdown map e ge

" clojure
" "Plug 'tpope/vim-surround' TODO: remap y
" "Plug 'git@github.com:slugbyte/paredit.vim'
" Fireplace
" autocmd Filetype clojure unmap! ;
" autocmd Filetype clojure unmap! I 
" autocmd Filetype clojure nmap ; cpp
" autocmd Filetype clojure nmap \| cmm
" autocmd Filetype clojure nmap I cqp
" "Plug 'neovim/nvim-lspconfig'
"Plug 'jpalardy/vim-slime'
"
"
     " vimgrep_arguments = {
     "   'rg',
     "   '--hidden',
     "   '--no-heading',
     "   '--with-fileeename',
     "   '--line-number',
     "   '--column',
     "   '--smart-case'
     " },

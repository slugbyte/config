call plug#begin('~/.config/nvim/plug')
" LANG
Plug 'pangloss/vim-javascript'
" TODO: fix forked and personal plugs
" Plug 'git@github.com:slugbyte/vim-clojure-static.git'

"" TEXT
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
"Plug 'SirVer/ultisnips'
"Plug 'git@github.com:slugbyte/snip.git'
"Plug 'tpope/vim-surround' TODO: remap y
"Plug 'git@github.com:slugbyte/paredit.vim'

"" UTIL
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'tpope/vim-fugitive' // fix y map

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

"" UI
"Plug 'scrooloose/syntastic'
"Plug 'git@github.com:slugbyte/yuejiu'
Plug 'airblade/vim-gitgutter'
Plug 'slugbyte/yuejiu'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

"" KEYMAP
Plug 'slugbyte/unruley-worker', {'branch': 'stage-3'}

call plug#end()
"
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugin Settings
" Vim-Slime
let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

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

" tmux-navigator
let g:tmux_navigator_save_on_switch = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" NERDTree
" auto close vim when only buf left is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=1
map <C-p> :NERDTreeToggle<CR>

" Paredit
let g:paredit_leader='\'
let g:paredit_shortmaps=1

" YouCompleteMe
au BufRead,BufNewFile *.clj let g:ycm_seed_identifiers_with_syntax=1 

" Fireplace
"autocmd Filetype clojure unmap! ;
"autocmd Filetype clojure unmap! I 
autocmd Filetype clojure nmap ; cpp
autocmd Filetype clojure nmap \| cmm
"autocmd Filetype clojure nmap I cqp

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Settings
syntax enable              "  turn on syntax highlighting
colorscheme yuejiu
filetype plugin on         "  allow plugins to be applied to specifc file types
set ruler                  "  show the cursor position in the status bar
set number relativenumber  "  hybrid relative number
set mouse=a                "  allow the mouse to interact with vim
set autoread               "  when you run checktime it will refresh the file
set incsearch              "  vim starts searching while typing search string
set tabstop=2              "  make \t appear to be two spaces wide
set expandtab              "  convert tab to spaces (unless a filetype plugin changes that)
"set ignorecase             "  non-case sensitve serach
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
set wildmode=longest:full "  configure tab completion to list all matches when there is more than one
set wildmenu               "  enable tab completion in the command bar
set timeout
set ttimeout
"augroup Fastescape
  "autocmd!
  "au InsertEnter * set timeoutlen=0
  "au InsertLeave * set timeoutlen=1000
"augroup end

let g:is_bash=1            "  treat .sh files as bash scripts

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Key Mappings
" double tap "i" to escape 
" imap II <Esc> TODO STOP USING II 
" L jumps to end of line
map Y $
" H jumps to beginning of line
map O ^
" Use the spacebar as the leader key
let mapleader = "\<Space>"
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
nmap <leader>s :sp<cr>
nmap <leader>v :vs<cr>
nmap <leader>o :on<cr>
nmap <leader>d :hide<cr>
nmap <leader>h :wincmd h<cr>
nmap <leader>j :wincmd j<cr>
nmap <leader>k :wincmd k<cr>
nmap <leader>l :wincmd l<cr>
nmap <leader>n :wincmd n<cr>
nmap <leader>c :close<cr>
nmap <leader>< :15 wincmd <<cr>
nmap <leader>> :15 wincmd ><cr>
nmap <leader>= :10 wincmd +<cr>
nmap <leader>- :10 wincmd -<cr>


"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shorthand
" TODO: convert this to a snippet
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
"inoreabbrev <expr> #doc "<!DOCTYPE html>" 

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Commands
" rkload the ~/.vimrc
command! C :close
command! Reload source ~/.vimrc   


command! Jformat execute '%!python -m json.tool' | w  
" FZF shorthand
command! F Files 
command! B Buffers
command! A Ag
command! L Lines
command! BL BLines
command! Todo Lines todo 

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
command! MouseModeToggle :call MouseModeToggle()

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
command! IgnoreCaseToggle call IgnoreCaseToggle()


" <C-p> will toggle pastemode 
function! PasteModeToggle()
  if &paste == 0
    set paste ruler
    echo "paste mode on"
  else
    set nopaste ruler
    echo "paste mode off"
  endif
endfunction
command! PasteModeToggle :call PasteModeToggle()

function! HighlightModeToggle()
  set hlsearch!
  if &hlsearch == 0
    echo "highlight mode off"
  else
    echo "highlight mode on"
  endif
endfunction
command! HighlightModeToggle :call HighlightModeToggle()

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
command! RelativeNumberToggle :call RelativeNumberToggle()

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filetype Commands
au BufRead,BufNewFile *.md.txt set syntax=markdown
au BufRead,BufNewFile *.js.txt set syntax=javascript
au BufRead,BufNewFile *.html.txt set syntax=html
au BufRead,BufNewFile Dockerfile* set syntax=dockerfile
au BufRead,BufNewFile .env.* set syntax=sh

augroup softwrap
  autocmd VimResized *.md if (&columns > 80) | set columns=80 | endif
  autocmd BufEnter *.md if (&columns > 80) | set columns=80 | endif
augroup END

let g:syntastic_javascript_checkers=['eslint']

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% YANK To Clipboard
"nnoremap <expr> k (v:register ==# '"' ? '"+' : '')
"nnoremap <expr> kk (v:register ==# '"' ? '"+' : '') . 'yy'
"xnoremap <expr> k (v:register ==# '"' ? '"+' : '') . 'y'
"xnoremap <expr> K (v:register ==# '"' ? '"+' : '') . 'Y'

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FKEYS
noremap <leader>n :RelativeNumberToggle<CR>
noremap <leader>p :PasteModeToggle<CR>
noremap <leader>c :IgnoreCaseToggle<CR>
nnoremap <leader>h :HighlightModeToggle<CR>
nnoremap <leader>m :MouseModeToggle<CR>
" UltiSnips

let g:UltiSnipsExpandTrigger="<f12>"
let g:UltiSnipsJumpForwardTrigger="<f11>"
let g:UltiSnipsJumpBackwardTrigger="<f10>"

"source ~/.config/nvim/config/coc.vim
"
"coc 
"" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugins
call plug#begin('~/.vim/plugged')
" LANG
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fireplace'
Plug 'slugbyte/vim-clojure-static'


" TEXT
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'slugbyte/paredit.vim'

" UTIL
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/YouCompleteMe'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-fugitive'

" NAV
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

" UI
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'slugbyte/yuejiu'
call plug#end()
"
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugin Settings
" Vim-Slime
let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" NERDTree
" auto close vim when only buf left is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=1
map <C-p> :NERDTreeToggle<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<f12>"
let g:UltiSnipsJumpForwardTrigger="<f11>"
let g:UltiSnipsJumpBackwardTrigger="<f10>"

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
colorscheme yuejiu         "  use the yuejiu syntax colorscheme
filetype plugin on         "  allow plugins to be applied to specifc file types
set ruler                  "  show the cursor position in the status bar
set number relativenumber  "  hybrid relative number
set mouse=a                "  allow the mouse to interact with vim
set incsearch              "  vim starts searching while typing search string
set tabstop=2              "  make \t appear to be two spaces wide
set expandtab              "  convert tab to spaces (unless a filetype plugin changes that)
set ignorecase             "  non-case sensitve serach
set cursorline             "  highlight the line current cursor line
set shiftwidth=2           "  make vim indent functions apply or remove two spaces
set backspace=2            "  make backspace work like all other apps
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
let g:is_bash=1            "  treat .sh files as bash scripts

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Key Mappings
" double tap "i" to escape 
" imap II <Esc> TODO STOP USING II 
" L jumps to end of line
map L $
" H jumps to beginning of line
map H ^
" Use the spacebar as the leader key
let mapleader = "\<Space>"
" qq to requort Q to replay
nnoremap Q @q

" move lines 
nnoremap <leader>K mz:m-2<CR>`z==
nnoremap <leader>J mz:m+<CR>`z==
vnoremap <leader>K :m'<-2<CR>gv=`>my`<mzgv`yo`z
vnoremap <leader>J :m'>+<CR>gv=`<my`>mzgv`yo`z

" window managment
nmap <leader>s :sp<cr>
nmap <leader>v :vs<cr>
nmap <leader>o :on<cr>
nmap <leader>d :hide<cr>
nmap <leader>h :wincmd h<cr>
nmap <leader>j :wincmd j<cr>
nmap <leader>k :wincmd k<cr>
nmap <leader>l :wincmd l<cr>
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
command! Reload source ~/.vimrc   

" FZF shorthand
command! F Files 
command! B Buffers
command! A Ag
command! L Lines
command! BL BLines
command! Todo Lines todo 

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Functions 
" M  will toggle the mouse between 
" vim select and clipboard select
function! ToggleMouseMode()
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
nmap <leader>M :call ToggleMouseMode()<CR>

" <C-p> will toggle pastemode 
function! TogglePasteMode()
  if  &paste == 0
    set paste ruler
    echo "paste mode on"
  else 
    set nopaste ruler
    echo "paste mode off"
  endif
endfunction
nmap <leader>P :call TogglePasteMode()<CR>

" <f5> will toggle relative number
function! ToggleNumber()
  if &relativenumber == 0
    set number relativenumber
    echo "relative number on"
  else 
    set norelativenumber
    echo "relative number off"
  endif
endfunction
nmap <leader>N :call ToggleNumber()<CR>

" duck duck go something 
" inspired by https://github.com/junegunn/dotfiles/blob/master/vimrc#L1012
function! s:duck(pat)
  let query = substitute(a:pat, '["\n]', ' ', 'g')
  let query = substitute(query, '[[:punct:] ]', '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://duckduckgo.com/?q=%s"', query))
endfunction

" duck line and delete
noremap <leader>? <S-v>"gy:call <SID>duck(@g)<cr>gvddl
" Duck command
command! -nargs=1 Duck call s:duck(<f-args>)

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filetype Commands
au BufRead,BufNewFile *.md.txt set syntax=markdown
au BufRead,BufNewFile *.js.txt set syntax=javascript
au BufRead,BufNewFile *.html.txt set syntax=html

let g:syntastic_javascript_checkers=['eslint']

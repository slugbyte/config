"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugins
call plug#begin('~/.vim/plugged')
" LANG
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go' 

" TEXT
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'

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
Plug 'airblade/vim-gitgutter'
Plug 'slugbyte/yuejiu'
call plug#end()

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugin Settings
" Vim-Slime
let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" NERDTree
nmap <leader>t :NERDTreeToggle<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=1

function! s:noop()
endfunction
" UltiSnips
let g:UltiSnipsExpandTrigger="<f12>"
let g:UltiSnipsJumpForwardTrigger="<f11>"
let g:UltiSnipsJumpBackwardTrigger="<f10>"
    

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Settings
syntax enable              "  turn on syntax highlighting
colorscheme yuejiu         "  use the yuejiu syntax colorscheme
filetype plugin on         "  allow plugins to be applied to specifc file types
set ruler                  "  show the cursor position in the status bar
set number                 "  turn on line numbers
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
nmap <leader>j :move+<cr>
nmap <leader>k :move-2<cr>
nmap <leader>h <<
nmap <leader>l >>
vmap <leader>j :move+<cr>
vmap <leader>k :move-2<cr>
vmap <leader>h <<
vmap <leader>l >>
" Save and Quit 
nnoremap <leader>q :wqall<cr>
nnoremap <leader>s :w <cr>:echo "saved"<cr>

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shorthand
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
"inoreabbrev <expr> #doc "<!DOCTYPE html>" 

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Commands
" open the current dir
command! Dir e .     
" reload the ~/.vimrc
command! Reload source ~/.vimrc   
" Find todos in all lines
command! Todo Lines todo 

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Functions 
" M  will toggle the mouse between 
" vim select and clipboard select
function! ToggleMouseMode()
  if  &mouse == "a"
    " cilpboard select will also hide line numbers
    set mouse=v nonumber
    echo "mouse mode clipboard"
  else 
    " vim select will also show line numbers
    set mouse=a number
    echo "mouse mode vim"
  endif
endfunction
map M :call ToggleMouseMode()<CR>

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
map <C-p> :call TogglePasteMode()<CR>

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

" FZF shorthand
command! F Files
command! B Buffers
command! A Ag
command! L Lines
command! BL BLines


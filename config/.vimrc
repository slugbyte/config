" PLUGINS 
call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'jpalardy/vim-slime'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
" Plug 'pangloss/vim-javascript'
call plug#end()


"OPTIONS 
filetype plugin on
set foldmethod=indent
set foldnestmax=5
set nofoldenable
set number                 " turn on line numbers
set backspace=2            " make backspace work like all other apps
set incsearch              " vim starts searching while typing search string
set expandtab              " tabs are spaces
set tabstop=2              " tabset two spaces
set shiftwidth=2           " tabset two space
set wildmenu               " enable tab completion
set wildmode=list:longest  " configure tab completion to list all matches when there is more than one
set encoding=utf8          " set standared encoding as utf8
set ruler                  " allways show the current position
set laststatus=2           " allways show the status line
set cursorline             " place a line uner the line where the cursor is
let g:is_bash=1            " .sh files are bash scripts bourne scripts
if has('mouse')            " enable the mouse if its supported
  set mouse=a
endif

" KEY MAPPINGS
imap ii <Esc>
map L $
map H ^
let mapleader = "\<Space>"

" TOGGLE COPY PASTEABLE MOUSE MODE
function ToggleMouseMode()
  if  &mouse == "a"
    set mouse=v nonumber
  else 
    set mouse=a number
  endif
endfunction
map M :call ToggleMouseMode()<CR>

function TogglePasteMode()
  if  &paste == 0
    set paste
    echo "paste mode on"
  else 
    set nopaste
    echo "paste mode off"
  endif
endfunction
map <C-p> :call TogglePasteMode()<CR>

" COLORS
syntax enable             
colorscheme jellybeans

" PLUGIN CONFIG
let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

let g:rustfmt_autosave=1 
let g:rust_clip_command='pbcopy'

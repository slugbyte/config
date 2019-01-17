" Plugins 
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'jpalardy/vim-slime'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'slugbyte/yuejiu'
call plug#end()

" Settings
syntax enable              " turn on syntax highlighting
colorscheme yuejiu         " use the yuejiu syntax colorscheme
filetype plugin on         " allow plugins to be applied to specifc file types
set ruler                  " show the cursor position in the status bar
set number                 " turn on line numbers
set mouse=a                " allow the mouse to interact with vim
set incsearch              " vim starts searching while typing search string
set tabstop=2              " make \t appear to be two spaces wide
set expandtab              " convert tab to spaces (unless a filetype plugin changes that)
set cursorline             " highlight the line current cursor line
set shiftwidth=2           " make vim indent functions apply or remove two spaces 
set backspace=2            " make backspace work like all other apps
set scrolloff=5            " when scrolling up keep 5 lines of code at the top of the screen 
set nofoldenable           " stop vim from folding indent levels when opening a file
set laststatus=2           " show the status line
set foldnestmax=4          " dont fold more than four levels deep
set encoding=utf8          " treat all text as utf-8
set showbreak="+++ "       " mark the lines that overflow screen width using +++
set foldmethod=indent      " fold and unfold text based on indent level
set completeopt-=preview   " stop plugins from adding a docs window on tab completion
set wildmode=list:longest  " configure tab completion to list all matches when there is more than one
set wildmenu               " enable tab completion in the command bar
let g:is_bash=1            " treat .sh files as bash scripts

" Key Mappings
" double tap "i" to escape 
imap ii <Esc>
" L jumps to end of line
map L $
" H jumps to beginning of line
map H ^
" Use the spacebar as the leader key
let mapleader = "\<Space>"

" Commands
command! Dir e .                  " open the current directory
command! Reload source ~/.vimrc   " reload the vim config

" Plugin Settings
" Vim-Slime
let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" Rust lang 
let g:rustfmt_autosave=1 
let g:rust_clip_command='pbcopy'

" Functions
" M  will toggle the mouse between 
" vim select and clipboard select
function ToggleMouseMode()
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
function TogglePasteMode()
  if  &paste == 0
    set paste ruler
    echo "paste mode on"
  else 
    set nopaste ruler
    echo "paste mode off"
  endif
endfunction
map <C-p> :call TogglePasteMode()<CR>

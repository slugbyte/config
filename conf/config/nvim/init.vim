call plug#begin('~/.config/nvim/plug')
  " HARPOON
  Plug 'nvim-lua/plenary.nvim' 
  " Plug 'ThePrimeagen/harpoon'
  " LANG
  Plug 'cespare/vim-toml'
  Plug 'leafgarland/typescript-vim'
  " UTILS
  " switch between vim an tmux pains using the same keystroke
  Plug 'christoomey/vim-tmux-navigator'
  " eunch - unix shell command helpers like :Delete and :Rename
  Plug 'tpope/vim-eunuch'
  " visual navigator of the undo tree 
  Plug 'mbbill/undotree'
  " comment out code easily
  Plug 'tpope/vim-commentary'
  Plug 'easymotion/vim-easymotion'
  " intelicense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Telescope
  " Plug 'nvim-lua/popup.nvim'
  " Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope.nvim'

  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " UI
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'git@github.com:slugbyte/yuejiu'

  " KEYMAP (load last b/c it could break other plugins)
  " TODO @slugbyte refactor unruly-worker branch structure
  Plug 'git@github.com:slugbyte/unruly-worker', {'branch': 'stage-3'}
call plug#end()

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Settings
syntax enable              "  turn on syntax highlighting
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
set ignorecase             "  non-case sensitive search 
set smartcase              " ignorecase unless the search uses uppercase
set cursorline             "  highlight the line current cursor line
set shiftwidth=2           "  make vim indent functions apply or remove two spaces
set backspace=2            "  make backspace 
set scrolloff=5            "  when scrolling up keep 5 lines of code at the top of the screen
set nofoldenable           "  stop vim from folding indent levels when opening a file
set laststatus=2           "  show the status line
set foldnestmax=4          "  don't fold more than four levels deep
set encoding=utf8          "  treat all text as utf-8
set showbreak="+++ "       "  mark the lines that overflow screen width using +++
set foldmethod=indent      "  fold and unfold text based on indent level
set completeopt-=preview   "  stop plugins from adding a docs window on tab completion
set wildmode=list:longest  "  configure tab completion to list all matches when there is more than one
set wildmenu               "  enable tab completion in the command bar
set colorcolumn=80         "  enable a visible column on the 80th char -(see)->
set clipboard=unnamedplus  "  use tes system clipboard for copy and paste
set nowrap                 "  don't wrap lines around
set undofile               "  always keep an undo histroy
set undodir=~/.local/slugbyte/nvim_undo
let g:is_bash=1            "  treat .sh files as bash scripts
set nohlsearch

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Highlight
highlight ExtraWhitespace ctermbg=240
match ExtraWhitespace /\s\+$/

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plugin Settings
source ~/.config/nvim/config/coc.vim
let g:gitgutter_map_keys = 0
let g:NERDCreateDefaultMappings = 0

" EasyMotion_do_mapping
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_keys = "123456789"

" lightline
function! LightlineFilename()
  let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
  return filename
endfunction

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

" FZF
let g:fzf_default_command = 'rg --files --hidden --ignore'
command! F Files
command! S Rg

" HARPOON
" command HarpoonAddFile :lua require("harpoon.mark").add_file()<CR>
" command HarpoonNavFile1 :lua require("harpoon.ui").nav_file(1)<CR>
" command HarpoonNavFile2 :lua require("harpoon.ui").nav_file(2)<CR>
" command HarpoonNavFile3 :lua require("harpoon.ui").nav_file(3)<CR>
" command HarpoonNavFile4 :lua require("harpoon.ui").nav_file(4)<CR>
" command HarpoonToggleQuickMenu :lua require("harpoon.ui").toggle_quick_menu()<CR>
" command HarpoonGotoTerminal1 :lua require("harpoon.term").gotoTerminal(1)<CR>
" command HarpoonGotoTerminal2 :lua require("harpoon.term").gotoTerminal(2)<CR>

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Functions
" Npm Lint
function! NpmLintFix()
  silent exe "!npm run lint:fix"
  redraw!
  bufdo! checktime
endfunction
command! NpmLintFix call NpmLintFix()

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
    echo "mouse mode normal"
  endif
endfunction
command! MouseModeToggle :call MouseModeToggle()

" Toggle case sensitive search
function! IgnoreCaseToggle()
  set ignorecase!
  if  &ignorecase == 0
    echo "ignorecase off"
  else
    echo "ignorecase on"
  endif
endfunction
command! IgnoreCaseToggle call IgnoreCaseToggle()

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
command! PasteModeToggle :call PasteModeToggle()

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

function! HighlightSearchToggle()
  set hlsearch!
  if  &hlsearch== 0
    echo "highlight off"
  else
    echo "highlight on"
  endif
endfunction
command! HighlightSearchToggle call HighlightSearchToggle()

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filetype Commands
au BufRead,BufNewFile *.md.txt set syntax=markdown
au BufRead,BufNewFile *.js.txt set syntax=javascript
au BufRead,BufNewFile *.html.txt set syntax=html
au BufRead,BufNewFile Dockerfile* set syntax=dockerfile
au BufRead,BufNewFile .env.* set syntax=sh
autocmd FileType markdown setlocal wrap
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown setlocal linebreak
autocmd FileType markdown setlocal spell

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Commands
command! Reload source ~/.config/nvim/init.vim
command! Replace %s/<c-r><c-w>/
command! JSONformat execute '%!python -m json.tool' |w
command! EditConfig :e ~/.config/nvim/init.vim
" <leader>c is close the current pane

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mappings
let mapleader = " "
" <leader>s is check spelling
nmap <leader>s <Plug>(coc-codeaction-selected)aw
nmap <leader>S :CocCommand cSpell.addWordToUserDictionnary<cr>

" <leader> c is toggle comment
map <leader>c gcc<esc>
" <leader>t is goto any char on screen
map <leader>t <Plug>(easymotion-overwin-f)
" <leader>c is close the current pane
map <leader>x 'close<CR>
" <leader>o is close the current pane
" map <leader>o 'on<CR>
" search file names quick
map <leader>f 'F<CR>
" search file content quick
nmap <leader>F 'S<CR>
" write
map <leader>w 'w<CR>
" quit
map <leader>q 'q<CR>

" map <leader>y 'HarpoonToggleQuickMenu<CR>
" map <leader>Y 'HarpoonAddFile<CR>
" map <leader>n 'HarpoonNavFile1<CR>
" map <leader>e 'HarpoonNavFile2<CR>
" map <leader>o 'HarpoonNavFile3<CR>
" map <leader>i 'HarpoonNavFile4<CR>



" {n,e,y,o} use visual navigaton instead of line navigaton
map n gn
map e ge
map y gy
map o go
au VimEnter * unmap @

" map <C-o> to fullscreen a pain
map <C-f> 'on<CR>

" vim-command-line key binding
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==
inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

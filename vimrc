" .vimrc file

"
" Vundle plugins
"
scriptencoding utf-8
set encoding=utf-8

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#rc()
call vundle#begin()


Plugin 'michalbachowski/vim-wombat256mod'

Plugin 'bling/vim-airline'
Plugin 'paranoida/vim-airlineish'
Plugin 'kien/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ledger/vim-ledger'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'vundle'
call vundle#end()


filetype plugin indent on


" Automatic reloading of .vimrc
"" autoumd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F4>
"" set clipboard=unnamed


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set ttymouse=xterm2
set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = '\'


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <Leader>h :nohl<CR>
vnoremap <Leader>h :nohl<CR>


" <F2> removes trailing whitespaces and saves file
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nnoremap <silent> <F2> :call Preserve("%s/\\s\\+$//e")<CR>:w<CR>
inoremap <silent> <F2> <ESC>:call Preserve("%s/\\s\\+$//e")<CR>:w<CR>
nmap _= :call Preserve("normal gg=G")<CR>


" Quicksave command
" noremap <F2> :update<CR>
" vnoremap <F2> <C-C>:update<CR>
" inoremap <F2> <C-O>:update<CR>


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between buffers
map <Leader>n <esc>:bp<CR>
map <Leader>m <esc>:bn<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod
hi Normal		ctermfg=254		ctermbg=250		cterm=none		guifg=#f6f3e8


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

hi CursorLine   cterm=NONE ctermbg=black
set cursorline  " highlight current line

" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set backupdir=$HOME/tmp
set directory=$HOME/tmp
"" set nobackup
"" set nowritebackup
"" set noswapfile

" Airline
" unicode symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = 'airlineish'

" Show invisible chars
nmap <leader>l :set list!<CR>
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:»\ ,eol:¬
let &listchars="eol:\u00b6,tab:\u25b8\ "
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
set laststatus=2

" Toogle comments

" map <C-_> NERDComToggleComment
vmap <C-_> <leader>c<space>gv
nmap <C-_> <leader>c<space>

" Settings for ctrlp
let g:ctrlp_max_height = 30
noremap p :CtrlPBuffer<CR>
set wildignore+=*.pyc
set wildignore+=*.wav
set wildignore+=*_build/*
set wildignore+=*/coverage/*


map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

"" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 0
let g:syntastic_javascript_checkers = ["jshint"]
let g:syntastic_html_jshint_conf = "$HOME/.jshintrc"
let g:syntastic_coffeescript_checkers = ["coffeelint"]
let g:syntastic_cpp_compiler = "g++"
" let g:syntastic_cpp_compiler_options = " -std=c++11"
let g:syntastic_java_checkers = []
let g:syntastic_error_symbol = "X"
let g:syntastic_style_error_symbol = ">"
let g:syntastic_warning_symbol = "!"
let g:syntastic_style_warning_symbol = ">"
let g:syntastic_python_checkers=['flake8']

" Completion
" Disable jedi (You Complete Me uses jedi)
let g:jedi#popup_on_dot = 0

set viminfo='10,\"100,:20,%,n~/.viminfo

" Filetype specific indentation
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

set exrc

set secure


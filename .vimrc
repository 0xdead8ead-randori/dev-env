"=============== General Config ====================
"
set background=dark

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
"set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set encoding=utf-8

set hidden

"turn on syntax highlighting
syntax on

"set cursorline                 " highlight current line
filetype indent on              " load filetype-specific indent files
set showmatch                   " highlight matching [{()}]

" Indentation Configuration for Python -- hopefully this works.
set expandtab                   " tabs are spaces
set tabstop=4           " use 4 spaces to represent tab
set textwidth=120       " break lines when line length increases
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line"

set smartindent     "Automatically inserts indentation in some cases
set cindent         "Like smartindent, but stricter and more customisable

set nocompatible

"-------------
" tab switching

" Show Tab Bar
set showtabline=1

map <A-1> :tabnext 1<CR>
map <A-2> :tabnext 2<CR>
map <A-3> :tabnext 3<CR>
map <A-4> :tabnext 4<CR>
map <A-5> :tabnext 5<CR>
map <A-6> :tabnext 6<CR>
map <A-7> :tabnext 7<CR>
map <A-8> :tabnext 8<CR>
map <A-9> :tabnext 9<CR>
map <A-0> :tabnext 10<CR>

" NERDTree Toggle Button Ctrl+n
"
nmap <C-n> :NERDTreeToggle<CR>

"--------------------------
"Vundle Install
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
"Plugin 'davidhalter/jedi-vim'       " Python Autocompletion
Plugin 'airblade/vim-gitgutter'     " Git Gutter
Plugin 'scrooloose/nerdtree.git'    " NerdTree
"Plugin 'flazz/vim-colorschemes'     " Collection of ColorSchemes
Plugin 'kien/ctrlp.vim'             " Ctrl+P for opening files
Plugin 'majutsushi/tagbar'          " Tagbar Plugin

" Golang Development
"Plugin 'fatih/vim-go'              " Golang Development in Vim Plugin
Plugin 'Valloric/YouCompleteMe'     " YouCompleteMe

Plugin 'jiangmiao/auto-pairs'       " AutoPairs (Closing Brackets)
"Plugin 'Townk/vim-autoclose'        " AutoClose Parenthesis & Brackets

" Linting Engine
"Plugin 'w0rp/ale'

Plugin 'psf/black'                  " Black Code Formatting Plugin

"Flake8 Vim Plugin
Plugin 'nvie/vim-flake8'            " Flake8 Plugin


"Plugin ''   " Comment
"Plugin ''   " Comment
"Plugin ''   " Comment
"Plugin ''   " Comment

call vundle#end()            " required
filetype plugin indent on    " required

"---------------------------

" Start NERDTREE By Default
"
" autocmd VimEnter * NERDTree


let g:ycm_autoclose_preview_window_after_insertion = 1      "Remove function prototype when leave insert mode with YCM

" Set Vim Filename Status Bar
set laststatus=2
set statusline=%f

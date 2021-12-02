call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-ruby/vim-ruby'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'stephpy/vim-yaml'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'alvan/vim-closetag'
Plug 'elixir-editors/vim-elixir'
Plug 'wellle/targets.vim'
Plug 'luochen1990/rainbow'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'machakann/vim-highlightedyank'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'ziglang/zig.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'rking/ag.vim'
Plug 'github/copilot.vim'

call plug#end()

let NERDTreeShowHidden=1
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
let g:salve_auto_start_repl=1
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.js,*.erb,*.mjml,*.vue'
let g:NERDSpaceDelims=1
let g:highlightedyank_highlight_duration = 500

colorscheme gruvbox
filetype plugin indent on   " Automatically detect file types.
filetype plugin on
syntax on                   " Syntax highlighting
scriptencoding utf-8
set shortmess+=c

" Make Space the leader
let mapleader=" "
set grepprg=ag\ --nogroup\ --nocolor
set scrolloff=10
set nostartofline
" insert spaces when hitting tab in insert mode
set expandtab
" Can leave unsaved buffers
set hidden
set number relativenumber
set ignorecase             " case insensitive search
set smartcase              " case sensitive when searching uppercase
set nowrap                 " Do not wrap long lines
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
set nobackup
set nowritebackup
set cursorline                           " Highlight current line
set splitright                           " Puts new vsplit windows to the right of the current
set splitbelow                           " Puts new split windows to the bottom of the current
set nosmd                                " Don't show mode on bottom line
set mouse=a                              " Enable mouse scrolling
set updatetime=250
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
set undofile                " So is persistent undo ...
set undodir=~/.neovimundo

if !isdirectory(expand("~/.neovimundo"))
    call mkdir(expand("~/.neovimundo"), "", 0700)
endif

" Remappings
nnoremap <SPACE> <Nop>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>

" Easy window movement
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" Remove all highlights
nnoremap <Leader><Esc> :noh<CR>
" Easier search
nnoremap <Leader>f /
nnoremap <Leader>b ?

nnoremap <Leader>h :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader><tab> :e#<CR>

" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gl :Glog<CR>

" Copy to and from system clipboard
vmap <leader>y "*y
vmap <leader>p "*p

" Open config file
nnoremap <leader>con :e ~/.config/nvim/init.vim<CR>

nnoremap <C-s> :Telescope oldfiles<CR>
nnoremap <C-p> :Telescope find_files find_command=rg,--hidden,--files,--glob,!.git<CR>
nnoremap <Leader>o :Telescope lsp_workspace_symbols<CR>

" use ag to search for word under cursor
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
vnoremap <Leader>ag y:Ag <C-r>=fnameescape(@")<CR><CR>

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>

highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

nnoremap <C-g> :Ag<Cr>

lua require('lsp_config')
lua require('complete')
lua require('tcope')
runtime snip.vim

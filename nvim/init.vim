" nvim-tree.lua suggests to disable net rw plugin like this
let loaded = 1
let loaded_netrwPlugin = 1

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-ruby/vim-ruby'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'stephpy/vim-yaml'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'alvan/vim-closetag'
Plug 'elixir-editors/vim-elixir'
" additional text objects like di( or ca]
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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hashivim/vim-terraform'
Plug 'LnL7/vim-nix'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
" colorscheme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Plug 'morhetz/gruvbox'
Plug 'mileszs/ack.vim'
Plug 'slim-template/vim-slim'
Plug 'idanarye/vim-merginal'
Plug 'ruanyl/vim-gh-line'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'brooth/far.vim'

call plug#end()

colorscheme tokyonight

set colorcolumn=120
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
let g:salve_auto_start_repl=1
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.js,*.erb,*.mjml,*.vue'
let g:highlightedyank_highlight_duration = 500

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

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

" open urls under cursor with gx
nmap <silent>gx :sil !open <c-r><c-a><cr>

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

" Copy to and from system clipboard
vmap <leader>y "*y
vmap <leader>p "*p

" Open config file
nnoremap <leader>cone :e ~/.config/nvim/init.vim<CR>
" source config file
nnoremap <leader>conr :source ~/.config/nvim/init.vim<CR>

nnoremap <C-s> :Telescope buffers<CR>
nnoremap <C-p> :Telescope find_files find_command=rg,--hidden,--files,--glob,!.git<CR>
nnoremap <Leader>o :Telescope lsp_workspace_symbols<CR>

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-m> :NvimTreeFindFile<CR>

highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

" undefines <CR> in quickfix list to make it work for opening files
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" handlebars
au BufReadPost *.hbs set syntax=html

" Ack config
" Actually use ag not ack lol
let g:ackprg = 'ag --vimgrep --hidden'

" use ack to search for word under cursor
nnoremap <silent> <Leader>ag :Ack! <C-R><C-W><CR>

function! VAckSearch()
  norm! gv"sy
  return ':Ack! "' . EscapeAllString(@s) . '"'
endfunction

function! EscapeAllString(text)
  return substitute(escape(a:text, '*^$.?/\|{[()]}'), '\n', '\\n', 'g')
endfunction

vnoremap <Leader>ag :<C-u>exec VAckSearch()<CR>

lua require('lsp_config')
lua require('complete')
lua require('tcope')
lua require('status_line')
lua require'nvim-tree'.setup()
runtime snip.vim

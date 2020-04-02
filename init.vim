" ~/.config/nvim/init.vim
" A lot of credit to spf13

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'
Plug 'stephpy/vim-yaml'
Plug 'tonchis/vim-to-github' " :ToGithub
Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'
Plug 'chase/focuspoint-vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] 
let g:ag_working_path_mode="r"
let g:airline_theme='afterglow'

colorscheme afterglow

filetype plugin indent on   " Automatically detect file types.
filetype plugin on
syntax on                   " Syntax highlighting
scriptencoding utf-8

" Can leave unsaved buffers
set hidden
set number relativenumber
set ignorecase             " case insensitive search
set smartcase              " case sensitive when searching uppercase
set nowrap                 " Do not wrap long lines
set undodir=~/.neovimundo
set undofile                " So is persistent undo ...
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

if !isdirectory(expand("~/.neovimundo"))
    call mkdir(expand("~/.neovimundo", "", 0700))
endif

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remappings

" Make Space the leader
let mapleader=" "
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

imap <C-Q> <Plug>(neosnippet_expand_or_jump)
smap <C-Q> <Plug>(neosnippet_expand_or_jump)
xmap <C-Q> <Plug>(neosnippet_expand_target)

" Remove all highlights
nnoremap <Leader><Esc> :noh<CR>
" Easier search
nnoremap <Leader>f /
nnoremap <Leader>b ?

nnoremap <Leader>h :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>tn :NeomakeToggle<CR>

" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gl :Glog<CR>

" Open config file
nnoremap <leader>con :e ~/.config/nvim/init.vim<CR>

" Buffer management
nnoremap <Leader>l :ls<CR>
nnoremap <Leader><tab> :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

nnoremap <Leader>w :CtrlPBuffer<CR>
nnoremap <Leader>tag :Dispatch ctags --exclude=node_modules --exclude=.git -R .<CR>

map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>cc opp "#" * 90<c-m>pp caller<c-m>pp "#" * 90<esc>

highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1


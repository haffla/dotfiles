call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-ruby/vim-ruby'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
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
Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'alvan/vim-closetag'
Plug 'slim-template/vim-slim'
Plug 'rizzatti/dash.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'wellle/targets.vim'
Plug 'LnL7/vim-nix'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'amadeus/vim-mjml'
Plug 'chr4/nginx.vim'

call plug#end()

" ignores files in gitignore
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
let g:salve_auto_start_repl=1
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.js,*.erb,*.mjml'
let g:NERDSpaceDelims=1
let NERDTreeShowHidden=1

" Use ag for CTRL-P
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --follow --ignore .git -g ""'
" let g:ctrlp_use_caching=0
" let g:ctrlp_show_hidden=1

imap <C-l> <Plug>(coc-snippets-expand)
set grepprg=ag\ --nogroup\ --nocolor

colorscheme gruvbox

filetype plugin indent on   " Automatically detect file types.
filetype plugin on
syntax on                   " Syntax highlighting
scriptencoding utf-8

set scrolloff=10
" insert spaces when hitting tab in insert mode
set expandtab
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
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

if !isdirectory(expand("~/.neovimundo"))
    call mkdir(expand("~/.neovimundo", "", 0700))
endif

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

" Use tab for trigger completion
imap <silent><expr><TAB> coc#refresh()
" Rename Symbol
nmap <leader>cr <Plug>(coc-rename)
" Format buffer
nmap <leader>cf <Plug>(coc-format)
" Go to definition
nmap <silent> gd <Plug>(coc-definition)
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Format using Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

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
nnoremap <Leader><tab> :e#<CR>

" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gl :Glog<CR>

" Copy to and from system clipboard
vmap <leader>y "*y
vmap <leader>p "*p

" Dash: search word under cursor
nmap <silent> <leader>d <Plug>DashSearch

" Open config file
nnoremap <leader>con :e ~/.config/nvim/init.vim<CR>

nnoremap <Leader>w :Buffers<CR>
nnoremap <C-p> :Files<CR>
" nnoremap <Leader>tag :Dispatch ctags --exclude=node_modules --exclude=.git -R .<CR>

nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>
nnoremap <Leader>tag :Dispatch ctags --exclude=node_modules --exclude=.git -R .<CR>

highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

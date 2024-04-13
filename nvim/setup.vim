let g:salve_auto_start_repl=1
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.js,*.erb,*.mjml,*.vue'
let g:highlightedyank_highlight_duration = 500

" set t_Co=256

filetype plugin indent on   " Automatically detect file types.
filetype plugin on
syntax on                   " Syntax highlighting
scriptencoding utf-8
set shortmess+=c
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" use `set list` to see whitespace and `set nolist` to hide it

set colorcolumn=120
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

set grepprg=ag\ --nogroup\ --nocolor
set scrolloff=10
set nostartofline
" insert spaces when hitting tab in insert mode
set expandtab
" Can leave unsaved buffers
set hidden
set number!                " Show line numbers
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
nnoremap <leader>gb :Git blame<CR>

" Copy to and from system clipboard
vmap <leader>y "*y
vmap <leader>p "*p

" Open config file
nnoremap <leader>cone :e ~/.config/nvim/init.vim<CR>
" source config file
nnoremap <leader>conr :source ~/.config/nvim/init.vim<CR>

nnoremap <C-s> :Telescope buffers<CR>
nnoremap <C-x> :Telescope harpoon marks<CR>
nnoremap <silent> <Leader>x :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-p> :Telescope find_files find_command=rg,--hidden,--files,--glob,!.git<CR>
" :lua require("harpoon.ui").toggle_quick_menu()
nnoremap <Leader>o :Telescope lsp_workspace_symbols<CR>

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-m> :NvimTreeFindFile<CR>

nnoremap <leader>ak <cmd>Telescope live_grep<cr>
nnoremap <leader>ag <cmd>Telescope grep_string<cr>
vnoremap <leader>ag "zy:Telescope grep_string default_text=<C-r>z<cr>
" undefines <CR> in quickfix list to make it work for opening files
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" handlebars
au BufReadPost *.hbs set syntax=html

let test#strategy = "floaterm"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

" Tmux
let g:tmux_navigator_no_mappings = 1

noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>

" LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>

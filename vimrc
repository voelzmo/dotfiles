" use pathogen to easily load modules from ~/.vim/modules and such folders
execute pathogen#infect() 

syntax enable " enable syntax highlighting
filetype plugin indent on " enables filetype detection and loads indent files from ~/.vim/indent

" use solarized dark theme from https://github.com/altercation/Vim-colors-solarized
set background=dark
colorscheme solarized

" tabs and stuff
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number spaces inserted when pressing TAB
set expandtab " tabs are expanded to spaces

" all the ui-related things
set number " show line numbers
set showcmd " command in bottom bar
set cursorline " highlight current line
set showmatch " highlight matching brackets
set wildmenu " visual autocomplete for the command menu, e.g. completion for ':e ~/.vim<TAB>'
set lazyredraw " don't redraw when it is not necessary, e.g. during execution of macros
set hidden " allow hidden buffers

" searching & finding
set incsearch " incremental search while typing
set hlsearch " highlight search matches
" turn off current search highlight with \<space>
nnoremap <leader><space> :nohlsearch<CR>

" folding
set foldenable " enable folding, duh
set foldlevelstart=10 " start at level 10 to fold when opening a file
set foldnestmax=10 " maximum of 10 nested folds
set foldmethod=syntax " use syntax files to determine where to fold
" space open/closes folds
nnoremap <space> za


" toggle gundo (http://github.com/sjl/gundo.vim/) with \u
nnoremap <leader>u :GundoToggle<CR>

" save the session (including open windows) to reopen it later with vim -S
nnoremap <leader>s :mksession<CR>

" using silver_searcher for searching within a project https://github.com/rking/ag.vim
nnoremap <leader>a :Ag

" use CtrlP as fuzzy file matcher https://github.com/kien/ctrlp.vim.git
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" use silver_searcher to find files instead of internal file finder (see http://www.reddit.com/r/vim/comments/1vt4dg/a_good_vimrc/)
let g_ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" let NERDTree show hidden files
let NERDTreeShowHidden=1

" set better statusline
if has('statusline')
 set laststatus=2
" Broken down into easily includeable segments
 set statusline=%<%f\    " Filename
 set statusline+=%w%h%m%r " Options
 set statusline+=%{fugitive#statusline()} "  Git Hotness
 set statusline+=\ [%{&ff}/%Y]            " filetype
 set statusline+=\ [%{getcwd()}]          " current dir
 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*
 let g:syntastic_enable_signs=1
 set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

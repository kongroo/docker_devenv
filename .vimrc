set nocompatible
filetype off
filetype plugin indent off
" set rtp+=$GOROOT/misc/vim
set encoding=utf-8
set pyxversion=3
let g:python3_host_prog='/usr/bin/python3'
call plug#begin('~/.vim/plugged')
" Appearance
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
silent! let g:airline_theme = "angr"
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" let g:airline_symbols.branch = ''
Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233, 234]
silent! au VimEnter * RainbowParentheses
Plug 'Yggdroot/indentLine'

" Language support
"Plugin 'klen/python-mode'
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mattn/emmet-vim', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'javascript' }

" Coding
Plug 'Valloric/YouCompleteMe'
let g:ycm_auto_trigger=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_complete_in_comments=1
let g:ycm_server_log_level = 'error'
let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf = '/root/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui=0
set completeopt-=preview
set completeopt-=menu,menuone
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_filetype_blacklist = {}
nnoremap <leader>gr :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" if has('nvim')
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plug 'Shougo/deoplete.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'Shougo/deoplete-clangx', { 'for': 'cpp' }
" " Plug 'tweekmonster/deoplete-clang2', { 'for': 'cpp' }
" endif
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay = 0
" let g:deoplete#auto_complete_start_length = 2
" " let g:deoplete#enable_refresh_always = 0
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#sources#clang#std='c++1z'
" " let g:deoplete#num_processes = 2
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" " let g:deoplete#ignore_sources = {}
" " let g:deoplete#ignore_sources._ = ['buffer', 'around']

set completeopt-=preview
let g:echodoc#enable_at_startup = 1
Plug 'Shougo/echodoc.vim'

Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
let g:ultisnips_javascript = {
            \ 'keyword-spacing': 'always',
            \ 'semi': 'never',
            \ 'space-before-function-paren': 'always',
            \ }

Plug 'honza/vim-snippets'
" Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
noremap <Tab> :Autoformat<CR>
" noremap <Tab> :ALEFix<CR>

" let g:ale_completion_enabled = 1
Plug 'w0rp/ale'
let b:ale_linters = {'cpp': ['g++']}
let g:ale_lint_delay = 1000
let g:ale_python_flake8_options = '--max-line-length 120'
let g:ale_c_gcc_options = '-Wall -O0 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O0 -std=c++17'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
"let g:ale_fixers = {
            "\ '*': ['remove_trailing_lines', 'trim_whitespace'],
            "\ 'cpp': ['astyle'],
            "\ 'java': ['google_java_format'],
            "\ 'python': ['autopep8']
            "\ }

Plug 'mhinz/vim-signify'

" Others
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nmap <Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=32
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore = ['\.pyc$', '\.swp']

Plug 'tpope/vim-fugitive'
Plug 'kannokanno/previm'
"let g:previm_open_cmd="firefox --no-sandbox"

" Plug 'tyru/open-browser.vim'

" File find
Plug 'kien/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPMRU'] }
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
noremap <leader>f :CtrlPMRU<CR>
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
            \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg|tar|tar.gz|pyc)$',
            \ }

" Plug 'terryma/vim-multiple-cursors'
" Plug 'sjl/gundo.vim'
call plug#end()
filetype plugin indent on


" Hotkey
let mapleader = "\\"
vnoremap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>X :wqa<CR>
nmap <Leader>x :x<CR>
nmap <Leader>Q :qa!<CR>
nnoremap <Leader>to :tabnew<Space>
nnoremap <Leader>tn :tabnew<CR>

" Settings
set shell=zsh
set ruler
set number
set noshowmode
set hlsearch
set nowrap
syntax enable
syntax on
syntax keyword cppSTLtype initializer_list
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set tags=./tags;,tags
set foldmethod=syntax
set nofoldenable

autocmd InsertEnter * if !exists('w:last_fdm')
            \| let w:last_fdm=&foldmethod
            \| setlocal foldmethod=manual
            \| endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
            \| let &l:foldmethod=w:last_fdm
            \| unlet w:last_fdm
            \| endif


" save/recover
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
set undodir=~/.undo_history/
set undofile
nnoremap <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
nnoremap <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>

set incsearch
set pastetoggle=<F9>
set backspace=start,eol,indent

" autocmds
autocmd filetype python nnoremap <leader>r :w <bar> exec '!time python '.shellescape('%')<CR>
autocmd filetype javascript nnoremap <leader>r :w <bar> exec '!time node '.shellescape('%')<CR>
autocmd filetype cpp nnoremap <leader>r :w <bar> exec '!time g++ -w -O2 -std=c++17 '.shellescape('%').' -o /tmp/'.shellescape('%:p:t:r').' && time /tmp/'.shellescape('%:p:t:r').''<CR>
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2

" Color
set background=dark
silent! colorscheme hybrid_material
highlight Normal ctermbg=none

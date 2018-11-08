set nocompatible 
filetype off
filetype plugin indent off
" set rtp+=$GOROOT/misc/vim
call plug#begin('~/.vim/plugged')
" Appearance
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

" Language support
"Plugin 'klen/python-mode'
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mattn/emmet-vim', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'javascript' }

" Coding
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'

" Others
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
" File find
Plug 'kien/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPMRU'] }
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
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
set foldmethod=syntax
set nofoldenable
set tags=./.tags;,.tags

" Find/replace
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" no confirm、no full
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" no confirm、full
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" confirm、no full
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" confirm、full
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" save/recover
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
set undodir=~/.undo_history/
set undofile
nnoremap <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
nnoremap <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>

set incsearch
set pastetoggle=<F9>
set backspace=start,eol,indent

" Plugin Settings

" Valloric/YouCompleteMe 
let g:ycm_complete_in_comments=1
function! GetPython3()
    let ver = system('python --version')
    let py2 = matchstr($ver, '2\.[0-9]\.[0-9]')
    if empty(py2)
        return 'python3'
    endif
    return 'python'
endfunction
let g:ycm_python_binary_path = GetPython3()
" let g:ycm_server_log_level = 'info'
let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui=0
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
set completeopt-=preview
" let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_filetype_blacklist = {}
set completeopt=menu,menuone
nnoremap <leader>gr :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1

" SirVer/ultisnips
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
let g:ultisnips_javascript = {
            \ 'keyword-spacing': 'always',
            \ 'semi': 'never',
            \ 'space-before-function-paren': 'always',
            \ }

function! GetAllSnippets() 
  call UltiSnips#SnippetsInCurrentScope(1) 
  let list = [] 
  for [key, info] in items(g:current_ulti_dict_info) 
    let parts = split(info.location, ':') 
    call add(list, { 
      \"key": key, 
      \"path": parts[0], 
      \"linenr": parts[1], 
      \"description": info.description, 
      \}) 
    echon key ': ' info.description
    echo ''
  endfor 
endfunction 
noremap <F4> :call GetAllSnippets()<CR>

" Chiel92/vim-autoformat
noremap <F2> :Autoformat<CR>

" kien/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
noremap <leader>f :CtrlPMRU<CR>
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
  \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg|tar|tar.gz|pyc)$',
  \ }

" scrooloose/nerdtree
nmap <Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=32
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore = ['\.pyc$', '\.swp']

" vim-airline/vim-airline
silent! let g:airline_theme = "angr"
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" let g:airline_symbols.branch = ''

" w0rg/ale
let g:ale_lint_delay = 1000
let g:ale_python_flake8_options = '--max-line-length 120'
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" kannokanno/previm
"let g:previm_open_cmd="firefox --no-sandbox"

" autocmds
autocmd filetype python nnoremap <leader>r :w <bar> exec '!time python '.shellescape('%')<CR>
autocmd filetype javascript nnoremap <leader>r :w <bar> exec '!time node '.shellescape('%')<CR>
autocmd filetype cpp nnoremap <leader>r :w <bar> exec '!g++ -w -O2 -std=c++17 '.shellescape('%').' -o /tmp/'.shellescape('%:p:t:r').' && time /tmp/'.shellescape('%:p:t:r').''<CR>
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2

" Color 
set background=dark
silent! colorscheme hybrid_material
highlight Normal ctermbg=none

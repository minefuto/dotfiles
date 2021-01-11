"vim-plug{{{
try
  call plug#begin(stdpath('data') . '/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'google/vim-searchindex'
  Plug 'itchyny/lightline.vim'
  Plug 'neoclide/coc.nvim'
  Plug 'machakann/vim-sandwich'
  Plug 'sheerun/vim-polyglot'
  Plug 'simeji/winresizer'
  call plug#end()
catch
endtry
"}}}
"general{{{
syntax on
filetype plugin indent on
let g:mapleader = "\<Space>"
set number
set shortmess+=c
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,sjis
set fileformat=unix
set belloff=all
set completeopt=menuone,preview
set splitright
set splitbelow
set autoread
set wrap
set display=lastline
set wildmenu
set hidden
set noshowmode
set noswapfile
set nobackup
set nowritebackup
set noundofile
set incsearch
set ignorecase
set smartcase
set shortmess+=c
set signcolumn=yes
set hlsearch
set wrapscan
set write
set modifiable
set backspace=indent,eol,start
set expandtab
set updatetime=300
set tabstop=2
set shiftwidth=2
set clipboard+=unnamed,unnamedplus
set laststatus=2
set undofile
if !isdirectory(expand("$HOME/.vimundodir"))
  call mkdir(expand("$HOME/.vimundodir"), "p")
endif
set undodir=$HOME/.vimundodir
"}}}
"keymap{{{
noremap j gj
noremap gj j
noremap k gk
noremap gk k
nnoremap <silent> <F1> :<C-u>set relativenumber!<CR>
nnoremap <silent> <esc><esc> :<C-u>nohlsearch<CR>
nnoremap x "_x
nnoremap Q q
nnoremap <C-q> <Nop>
nnoremap M m
vnoremap * "zy:let @/ = @z<CR>n
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
"}}}
"language{{{
augroup lang_augroup
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType go setlocal sw=4 ts=4 sts=4 noexpandtab
  autocmd BufWritePre *.go :%!gofmt
augroup end
"}}}
"coc-nvim{{{
if empty(globpath(&rtp, 'autoload/coc.vim')) == 0
  let g:coc_global_extensions = [
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-pairs',
      \ 'coc-snippets',
      \ 'coc-sh',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]
  let g:coc_status_error_sign = '×'
  let g:coc_status_warning_sign = '•'

  inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <leader>rn <Plug>(coc-rename)
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  augroup coc_augroup
    autocmd!
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  "coc-explorer{{{
  nmap <leader>e :CocCommand explorer<CR>
  "}}}
  "coc-snippets{{{
  let g:coc_snippet_next = '<c-j>'
  let g:coc_snippet_prev = '<c-k>'

  vmap <C-j> <Plug>(coc-snippets-select)
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  "}}}
endif
"}}}
"vim-lightline{{{
if empty(globpath(&rtp, 'autoload/lightline.vim')) == 0
  let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'git' ],
      \     [ 'readonly', 'filename' ],
      \     [ 'cocstatus' ],
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'fileformat' ],
      \     [ 'fileencoding' ],
      \     [ 'filetype' ],
      \   ]
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'git': 'CocGitStatus',
      \   'filename': 'LightlineFilename',
      \ },
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }

  function! CocGitStatus()
    return get(g:, 'coc_git_status', '') . ' ' . get(b:, 'coc_git_status', '')
  endfunction

	function! LightlineFilename()
		return &modifiable && &modified ? expand('%:t') . '*' : expand('%:t')
	endfunction

  augroup lightline_augroup
    autocmd!
    autocmd User CocStatusChange,CocDiagnosticChange,CocGitStatusChange call lightline#update()
  augroup end
endif
"}}}
"winresizer{{{
if empty(globpath(&rtp, 'autoload/winresizer.vim')) == 0
  let g:winresizer_enable = 1
  let g:winresizer_start_key = '<leader>w'
endif
"}}}
"nord-vim{{{
if empty(globpath(&rtp, 'colors/nord.vim')) == 0
  colorscheme nord
endif
"}}}

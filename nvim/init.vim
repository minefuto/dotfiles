"OS valiable setting{{{
if has('nvim')
  let g:DEFAULT_DIR = $HOME . '/.config/nvim/'
elseif has('win32') || has('win64')
  let g:DEFAULT_DIR = $HOME . '/vimfiles/'
elseif has('unix')
  let g:DEFAULT_DIR = $HOME . '/.vim/'
endif
"}}}
"Vim-plug setting{{{
try
  call plug#begin(DEFAULT_DIR . 'plugged/')
  Plug 'ap/vim-buftabline'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'google/vim-searchindex'
  Plug 'machakann/vim-sandwich'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'simeji/winresizer'
  Plug 'thinca/vim-quickrun'
  Plug 'tpope/vim-fugitive'
  Plug 'zah/nim.vim'
  call plug#end()
catch
endtry
"}}}
"General setting{{{
syntax on
filetype plugin indent on
let g:mapleader = "\<Space>"
set number
set shortmess+=c
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,sjis
set fileformat=unix
set ambiwidth=double
set completeopt=menuone,preview
set splitright
set splitbelow
set showmode
set autoread
set wrap
set display=lastline
set wildmenu
set hidden
set noswapfile
set nobackup
set noundofile
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
set write
set modifiable
set backspace=indent,eol,start
set expandtab
set tabstop=2
set shiftwidth=2
set clipboard+=unnamed,unnamedplus
set laststatus=2
set statusline=%F%m%y%=
if empty(globpath(&rtp, 'autoload/fugitive.vim')) == 0
  set statusline+=%{fugitive#statusline()}
endif
set statusline+=[enc=%{&fileencoding}]
set statusline+=[low=%l/%L]
augroup fileset
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
"Key mapping{{{
noremap <C-j> <esc>
noremap! <C-j> <esc>
noremap j gj
noremap gj j
noremap k gk
noremap gk k
nnoremap <silent> <F1> :<C-u>set relativenumber!<CR>
nnoremap <silent> <C-j><C-j> :<C-u>nohlsearch<CR>
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
"Terminal setting{{{
if has('unix')
  set shell=fish
elseif has('win32') || has('win64')
  set shell=powershell
endif
if has('nvim')
  tnoremap <silent> <C-j> <C-\><C-n>
elseif has('terminal')
  set termwinkey=<m-w>
  tnoremap <C-j> <m-w><s-n>
endif
"}}}
"Vim-lsp setting{{{
if empty(globpath(&rtp, 'autoload/lsp.vim')) == 0
  let g:lsp_diagnostics_enabled = 1
  let g:lsp_signs_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_highlights_enabled = 0
  let g:lsp_textprop_enabled = 0
  let g:lsp_signature_help_enabled = 0
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_popup_delay = 30
  let g:lsp_virtual_text_enabled = 0
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer><silent> ]d <plug>(lsp-next-diagnostic)
    nmap <buffer><silent> [d <plug>(lsp-previous-diagnostic)
    inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
    inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
"    inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"

"    function! s:check_back_space() abort
"      let col = col('.') - 1
"      return !col || getline('.')[col - 1]  =~ '\s'
"    endfunction
"
"    inoremap <silent><expr> <C-n>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<C-n>" :
"      \ asyncomplete#force_refresh()
  endfunction

  augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

endif
"}}}
"Vim-fugitive setting{{{
if empty(globpath(&rtp, 'autoload/fugitive.vim')) == 0
  nnoremap <Leader>gb :<C-u>Gblame<CR>
  nnoremap <Leader>gc :<C-u>Gcommit<CR>
  nnoremap <Leader>gd :<C-u>Gdiff<CR>
  nnoremap <Leader>gm :<C-u>Gmerge<CR>
  nnoremap <Leader>gp :<C-u>Gpull<CR>
  nnoremap <Leader>gs :<C-u>Gstatus<CR>
endif
"}}}
"Buftabline setting{{{
let g:buftabline_indicators = 1
"}}}
"Winresizer setting{{{
if empty(globpath(&rtp, 'autoload/winresizer.vim')) == 0
  let g:winresizer_enable = 1
  let g:winresizer_start_key = '<Leader>w'
endif
"}}}
"Neosnippet setting{{{
if empty(globpath(&rtp, 'autoload/neosnippet.vim')) == 0
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endif
"}}}
"Base16 setting{{{
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  try
    source ~/.vimrc_background
  catch
  endtry
endif
"}}}
"Vim-tmux-nagigater setting{{{
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-q>h :TmuxNavigateLeft<CR>
nnoremap <silent> <C-q>j :TmuxNavigateDown<CR>
nnoremap <silent> <C-q>k :TmuxNavigateUp<CR>
nnoremap <silent> <C-q>l :TmuxNavigateRight<CR>
"}}}

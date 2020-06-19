set t_Co=256
set mouse=

if has('mac')
  set columns=180
  set lines=50
  set guifont=Cica:h14
elseif has('win32') || has ('win64') || has('unix')
  set columns=120
  set lines=50
  set guioptions-=m
  set guioptions-=T
  cd ~
  if has('nvim')
    Guifont! Cica:h11
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
    call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
  else
    set guifont=Cica:h11
  endif
endif

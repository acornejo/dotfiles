" Automatically show or hide numbers if the windows are narrow or wide.
"
function! s:vim_winchanged()
  let minwidth = min(map(range(1, winnr('$')), 'winwidth(v:val)'))
  let curwin=winnr()
  if minwidth < &textwidth + 3
    windo set nonumber
  else
    windo set number
  endif
  exe curwin. "wincmd w"
endfunction

function! s:vim_resized()
  wincmd =
  call s:vim_winchanged()
endfunction

autocmd! VimResized * call s:vim_resized()
autocmd! WinNew,WinLeave,WinEnter * call s:vim_winchanged()

" autocmd! WinEnter * set number
" autocmd! WinLeave * set nonumber

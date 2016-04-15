" Set window movement bindings (that play well with tmux)
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
        silent call system("tmux select-pane -" . a:tmuxdir)
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te"

  nnoremap <silent> <C-g>h :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-g>j :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-g>k :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-g>l :call TmuxOrSplitSwitch('l', 'R')<cr>
  inoremap <silent> <C-g>h <Esc>:call TmuxOrSplitSwitch('h', 'L')<cr>
  inoremap <silent> <C-g>j <Esc>:call TmuxOrSplitSwitch('j', 'D')<cr>
  inoremap <silent> <C-g>k <Esc>:call TmuxOrSplitSwitch('k', 'U')<cr>
  inoremap <silent> <C-g>l <Esc>:call TmuxOrSplitSwitch('l', 'R')<cr>

  " make cursors nice
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  map <C-g>h <C-w>h
  map <C-g>j <C-w>j
  map <C-g>k <C-w>k
  map <C-g>l <C-w>l
  " make cursors nice
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

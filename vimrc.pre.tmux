" disable since meta bindings break macros that use <Esc>char
finish

" fix meta key bindings
set ttimeout ttimeoutlen=50
if has("unix")
    let c='a'
    while c <= 'z'
        " maybe use "set <A-".nr2char(c)
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
endif

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

  nnoremap <silent> <M-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <M-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <M-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <M-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
  inoremap <silent> <M-h> <Esc>:call TmuxOrSplitSwitch('h', 'L')<cr>
  inoremap <silent> <M-j> <Esc>:call TmuxOrSplitSwitch('j', 'D')<cr>
  inoremap <silent> <M-k> <Esc>:call TmuxOrSplitSwitch('k', 'U')<cr>
  inoremap <silent> <M-l> <Esc>:call TmuxOrSplitSwitch('l', 'R')<cr>

  " make cursors nice
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  map <M-h> <C-w>h
  map <M-j> <C-w>j
  map <M-k> <C-w>k
  map <M-l> <C-w>l
  " make cursors nice
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

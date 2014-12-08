if filereadable(expand("$HOME/.vimbundle.vim"))
    if isdirectory(expand("$HOME/.vim/bundle/vundle"))
        source ~/.vimbundle.vim
    else
        echo "Must install vundle to handle plugins."
    endif
endif

"***********************************
"General VIM Config
"***********************************
syntax on
filetype plugin indent on
set background=dark
colorscheme solarized
set nocompatible            " No compatibility mode
set laststatus=2            " Always display status line
set winaltkeys=no           " Disable alt/meta for gui menus
set title titlestring=%t    " Set your xterm title
set history=1024            " Remember command line history
set sm                      " When a bracket is inserted briefly jump to the matching one
set wildmode=longest,list,full " tab completion
set wildmenu                " Enable wildmenu for completion with tab
set wildignore+=*/tmp/*,*.so,*.swp  " Ignore in completion
set autoread                " If file was changed outside, and no local changes, reload"
set novb t_vb=              " No visual error
set noeb                    " No sound for error (bell)
set textwidth=72            " Text width to do hard line wrap
set wrap lbr                " Use soft line wrap, wrap at words
set nojoinspaces            " Prevents double spaces when joining lines
set fileformat=unix         " Default file format
set cindent ai si           " Indenting Style, Auto indenting, smart indent new line
set tabstop=4 shiftwidth=4  " Number of spaces that a tab represents
set expandtab               " Expand tab to spaces
set smarttab                " Replace tab with spaces
set shiftround              " Round indents to multiples of shiftwidth
set backspace=2             " Allow backspace over indent, line breaks, or start of the line
set foldmethod=syntax       " set syntax controlled folding
set nofoldenable            " Remove to enable folding
set hlsearch                " Highlight search result
set ignorecase              " Search ignores case
set smartcase               " Search is case sensitive if using upper case
set incsearch               " Enable incremental search
set hidden                  " When abandoning a buffer, hide it
set noswapfile              " Disable swap file
set number                  " Enable line numbers
set virtualedit=onemore     " Allow for cursor beyond last character
set shortmess=filmnxtToOI   " Customize messages
set splitbelow              " Splits occur below current window
set splitright              " Splits occur to the right of current window
set nostartofline           " Don’t reset cursor to start of line when moving around.
set exrc                    " Enable per-directory .vimrc files

" Use clipboard register.
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
else
    set clipboard& clipboard+=unnamed
endif

" Storage of various files
set viminfo='10,\"100,:20,%,n~/.viminfo " save stuff to ~/.viminfo
set spellfile=~/.vimspell.add           " save new words
set spellsuggest=best,10
set viewdir=~/.vim_view                 " save views
set tags+=~/.vim_tags                   " set tags location
try
    set undofile                        " save undo to file
    set undodir=~/.vim_undo             " set undo directory
catch
endtry

" Change settings depending on mode
if (has("gui_running"))
    set guioptions-=m " remove menubar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove scrollbar
    set guioptions-=L " remove right scrollbar
    set gfn=Menlo:h12
    set mousemodel=popup
    set columns=110
    set lines=67
else
    hi SpellBad ctermfg=Red ctermbg=NONE guibg=NONE guifg=Red cterm=underline gui=underline term=reverse
    hi SpellCap ctermfg=Blue ctermbg=NONE guibg=NONE guifg=Blue cterm=underline gui=underline term=reverse
    if &term == "xterm" || &term == "screen-bce"
        set term=xterm
        set t_Co=256
    endif
    if &term =~ "256color"
        set t_ut=                   " disable background color erase
    endif
endif

"************************************
" Plugin settings
"************************************
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " Hide .* files
let g:netrw_browsex_viewer='open'     " Open files with viewer
let g:netrw_fast_browse=2            " Use fast browsing
let g:netrw_liststyle=1              " Display file details in browser
let g:netrw_hide=1                   " show not-hidden files
let g:python_failquietly=1           " Dont complain if there is no python
let g:buftabs_marker_start=""        " marker around active buftab
let g:buftabs_marker_end=""          " marker around active buftab
let g:buftabs_separator=":"          " marker around active buftab
let g:buftabs_marker_modified="+"    " Marker for modified buftabs
let g:buftabs_only_basename=1        " Show short name in buftabs
let g:buftabs_in_statusline=1        " Show buftabs in status line
let g:buftabs_inactive_highlight_group="StatusLine" " Color for inactive tabs
let g:buftabs_active_highlight_group="Title"   " Color for active tabs
let g:yankring_history_file = ".vim_yankring"
let g:yankring_min_element_length = 2
let g:ctrlp_cache_dir = $HOME . '/.vim_ctrlp_cache'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_map = '<c-8>'
let g:ctrlp_working_path_mode=0
let g:ctrlp_show_hidden = 0
let g:ctrlp_mruf_exclude = '/tmp/.*\|\.git/.*'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:UltiSnipsListSnippets="<c-q>"
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-q>"
let g:xmledit_enable_html = 1
let g:sparkupExecuteMapping="<c-i>"
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:syntastic_html_tidy_ignore_errors=['trimming empty', 'lacks "alt" attribute', 'lacks "src" attribute']
let g:syntastic_check_on_open = 0
let g:signify_vcs_list = [ 'git' ]
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_save_clipboard = 1
let g:unite_project_folder = '~/devel'

" unimpaired style maps for unite
nmap [z :UnitePrevious<CR>
nmap ]z :UniteNext<CR>
nmap [Z :UniteFirst<CR>
nmap ]Z :UniteLast<CR>

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    if &grepformat !~# '%c'
        set grepformat^=%f:%l:%c:%m
    endif
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command= 'ag --nocolor --nogroup -g ""'
    let g:ackprg = 'ag --nogroup --nocolor --column'
elseif executable('ack')
    let g:ctrlp_user_command = 'ack %s -f'
endif

call unite#custom#profile('default', 'context', {'start_insert': 1, 'winheight': 10, 'direction': 'botright', })
call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_current_file'])
call unite#filters#sorter_default#use(['sorter_rank'])

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    imap <buffer> <C-w>   <Plug>(unite_toggle_auto_preview)
    imap <buffer> <C-c>   <Plug>(unite_exit)
    imap <buffer> <Esc>   <Plug>(unite_exit)
    imap <silent><buffer><expr> <C-x> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nmap <buffer> <Esc>   <Plug>(unite_exit)
endfunction

"************************************
" Autocommands
"************************************
if has("autocmd")
    " Reload vimrc when modified
    autocmd! BufWritePost .vimrc source ~/.vimrc
    " Go to last position when reopening file
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Change tab stop for html + javascript
    autocmd FileType html,javascript setlocal ts=2 sw=2
    " Disable line wrap for html
    autocmd FileType html setlocal tw=10000
    " Indent and wrap settings for latex
    autocmd BufNewFile,BufRead *.tex setlocal ft=tex fo=tcqaw ts=2 sw=2 nocin colorcolumn=75
    " Set gnuplot filetype
    autocmd BufNewFile,BufRead *.plt,*.gnuplot setf gnuplot
    " Set tioa filetype
    autocmd BufNewFile,BufRead *.tioa setf tioa
    " Enable spell for text files
    autocmd BufNewFile,BufRead *.txt,*.html,*.tex,*.md,README setlocal spell spelllang=en_us
    " set make prog
    autocmd FileType java setlocal makeprg=javac\ % efm=%A%f:%l:\ %m,%+Z%p^,%+C%.%#,%-G%.%#
    autocmd FileType python setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\" efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    autocmd FileType gnuplot setlocal makeprg=cat\ %\\\|gnuplot\ \-persist\ \&
    autocmd FileType tioa setlocal makeprg=tempo.sh\ %
    " enable autocomplete
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
endif

"************************************
" Readline-like editing not in vim-rsi
"************************************
nnoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-k> <C-o>C
nnoremap <C-k> C
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>

"************************************
" Search backwards and fowards in command mode
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

"************************************
" Custom mappings
"************************************
let mapleader = ","
" Browse using ag
map <leader>a :Ack 
" Browse Recently Used Files
map <leader>r :Unite -start-insert -buffer-name=mure file_mru<CR>
" Browse Files in current directory
map <leader>f :Unite -start-insert -buffer-name=files file_rec/async:!<CR>
" Browse open buffers
map <leader>b :Unite -start-insert -buffer-name=buffers buffer<CR>
" Browse projects
map <leader>p :Unite -start-insert -buffer-name=projects projects<CR>
" Open Yank Ring
map <leader>y :Unite history/yank<CR>
" Browse current folder
map <leader>e :e .<CR>
" Switch to hexmode
map <leader>h <Plug>HexManager
" Run make in vmux
map <leader>m :call VimuxRunCommand("cd " . getcwd() . "; m")<CR>
map <leader>q :cfile /tmp/make.log<CR>:cw<CR>
" Prompt for vmux command
map <leader>v :call VimuxPromptCommand()<CR>
" Run Git status
map <leader>g :Gstatus<CR>
" Switch to the directory of the current buffer.
map <leader>c :cd %:p:h<cr>
" Tabularize shortcuts
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:<CR>
vmap <leader>a: :Tabularize /:<CR>

" Use sudo to overwrite files.
command! Wsudo :execute ':silent w !sudo tee % > /dev/null' | :edit!
command! -nargs=1 -complete=shellcmd Run | execute ':silent !'.<q-args> | execute ':redraw!'

" Smart identation with braces
inoremap {<CR> {<CR>}<c-o>O

" Switch off highlighting
nnoremap <CR> :noh<CR><CR>

" Save a few keystrokes
nnoremap ; :

" Autocorrect some common errors
iab disc disk
iab discs disks
iab Disc Disk
iab Discs Disks
iab colour color
iab neighbour neighbor
iab neighbours neighbors
iab neighbourhood neighborhood
iab behaviour behavior
iab Behaviour Behavior
iab centre center
iab Centre Center
iab ocurr occur
iab cancelling canceling
iab travelling traveling
iab Travelling traveling
iab Cancelling Canceling

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

  " Make cursor nice
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

" Shell command
function! s:Dict(command)
  let command = join(map(split('dict ' . a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^dict$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape('dict') : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap
  echo 'Searching for word ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> q :bd<CR>'
endfunction
command! -nargs=+ Dict call s:Dict(<q-args>)

" Strip trailing whitespace
function! s:Strip()
  execute "normal mz"
  %s/\s\+$//e
  execute "normal `z"
endfunction
command! Strip call s:Strip()

command! -bar -nargs=? -bang Scratch :silent enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<args> modifiable

function! s:LucCheckIfBufferIsNew(...)
  let number = a:0 ? a:1 : 1
  " save current and alternative buffer
  let current = bufnr('%')
  let alternative = bufnr('#')
  let value = 0
  " check buffer name
  if bufexists(number) && bufname(number) == ''
    silent! execute 'buffer' number
    let value = line('$') == 1 && getline(1) == ''
    silent! execute 'buffer' alternative
    silent! execute 'buffer' current
  endif
  return value
endfunction
autocmd VimEnter * if s:LucCheckIfBufferIsNew(1) | bwipeout 1 | doautocmd BufRead | endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

for f in split(glob("~/.vimrc.local.*"), "\n")
    execute 'source ' . escape(f, '\ "')
endfor

set secure                  " disable unsafe commands in per-directory .vimrc"

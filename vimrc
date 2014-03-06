if filereadable(expand("$HOME/.vimbundle.vim"))
    if isdirectory(expand("$HOME/.vim/bundle/vundle"))
        source ~/.vimbundle.vim
    else
        echo "Must install vundle to handle plugins."
    endif
endif

" zc to close fold, zo to open fold, zC to close ALL folds, zO to open all folds
"***********************************
"General VIM Config
"***********************************
syntax on
filetype plugin indent on
set background=dark
colorscheme solarized
set statusline=%<%f%h%m%r%h%w\ %=\ %{&ff}\ %y\ %{&paste?'[paste]':''}\ %l,%c\ \ %P
set laststatus=2            " Always display status line
set title titlestring=%t    " Set your xterm title
set history=1024            " Remember command line history
set nocp                    " No compatibility mode
set sm                      " When a bracket is inserted briefly jump to the matching one
set wildmenu                " Enable wildmenu for completion with tab
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
set clipboard=unnamed       " Copy to system clipboard
set shortmess=filmnxtToOI
"set completeopt=menuone     " remove preview from completeopt
"set cursorline              " Highlight current line (slow)
"set splitbelow              " Splits occur below current window
"set mouse=a                 " enables mouse use in normal mode (useful for resizing window)

" Storage of various files
set viminfo='10,\"100,:20,%,n~/.viminfo " save stuff to ~/.viminfo
set spellfile=~/.vimspell.add           " save new words
set spellsuggest=best,10
set viewdir=~/.vim_view                 " save views
set tags+=~/.vim_tags                   " save tags
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
    " Change to directory of opened file on startup.
    autocmd GUIEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
else
    hi SpellBad ctermfg=Red ctermbg=NONE guibg=NONE guifg=Red cterm=underline gui=underline term=reverse
    hi SpellCap ctermfg=Blue ctermbg=NONE guibg=NONE guifg=Blue cterm=underline gui=underline term=reverse
    if &term == "xterm" || &term == "screen-bce"
        set term=xterm
        set t_Co=256
        hi CursorLine term=none cterm=none ctermbg=236
    endif
    if &term =~ "256color"
        set t_ut=                   " disable background color erase
    endif
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif


"************************************
" Plugin settings
"************************************
let g:netrw_list_hide='^\.'          " Hide .* files when browsing
let g:netrw_browsex_viewer='viewer'  " Open files with viewer
let g:netrw_fast_browse=2            " Use fast browsing
let g:netrw_liststyle=1              " Display file details in browser
let g:python_failquietly=1           " Dont complain if there is no python
let g:NERDTreeQuitOnOpen = 1         " Quit after opening file
let g:NERDChristmasTree = 1          " Use colors in nerd tree
let g:NERDTreeShowBookmarks=1        " show bookmarks in nerd tree
let g:NERDTreeChDirMode=2            " change to current dir
let g:ConqueTerm_Color = 1           " Enable color for latest output
let g:ConqueTerm_CloseOnEnd = 1      " Close buffer when program ends
let g:ConqueTerm_InsertOnEnter= 1    " Start insert mode when entering buffer
let g:ConqueTerm_CWInsert = 1        " Allow <C-w> shortcuts
let g:ConqueTerm_TERM = 'xterm'      " Use vt100 for safety, xterm is experimental
"let g:ConqueTerm_FastMode = 1        " Make termainl faster (sacrifice color)
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
let g:ctrlp_map = '<c-t>'
let g:ctrlp_working_path_mode=0
let g:ctrlp_show_hidden = 0
let g:ctrlp_mruf_exclude = '/tmp/.*\|\.git/.*'
let g:ctrlp_user_command = 'ack %s -f'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:UltiSnipsListSnippets="<c-k>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:xmledit_enable_html = 1
let g:sparkupExecuteMapping="<c-i>"
let g:airline_powerline_fonts = 0
let g:syntastic_html_tidy_ignore_errors=['trimming empty', 'lacks "alt" attribute', 'lacks "src" attribute']
let g:syntastic_check_on_open = 1
let g:signify_vcs_list = [ 'git' ]

set wildignore+=*/tmp/*,*.so,*.swp

"************************************
" Autocommands
"************************************
" Reload vimrc when modified
autocmd! BufWritePost .vimrc source ~/.vimrc
" Go to last position when reopening file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Change directory to active buffer
" autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" && strlen(bufname("")) > 2 | cd %:p:h | endif
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

"************************************
" Emacs like motion
"************************************
imap <C-a> <Esc>0i
nmap <C-a> 0
imap <C-e> <Esc>$a
nmap <C-e> $
imap <C-f> <Esc>la
imap <C-b> <Esc>ha
imap <C-k> <Esc>ld$a
imap <C-d> <Delete>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"************************************
" Movement with line-wrapping
"************************************
" nnoremap j gj
" nnoremap k gk
" nnoremap ^ g^
" nnoremap $ g$

"************************************
" Moving Between buffers
"************************************
" noremap <C-H> :bprev!<CR>
" noremap <C-L> :bnext!<CR>
" noremap <C-K> :bd<CR>

"************************************
" Custom mappings
"************************************
let mapleader = ","
" Open terminal
map <leader>t :ConqueTermSplit bash<CR>
" Browse Recently Used Files
map <leader>r :CtrlPMRUFiles<CR>
" Browse Files in current directory
map <leader>f :CtrlP<CR>
" Browse Current Directory
map <leader>e :NERDTreeToggle<CR>
" Switch to hexmode
map <leader>h <Plug>HexManager
" Open Yank Ring
map <leader>y :YRShow<CR>
" Run make in vmux
map <leader>m :call VimuxRunCommand("make")<CR>
" Run Git status
map <leader>g :Gstatus<CR>
" Open a mini buffer explorer
set wcm=<C-Z>
map <leader>b :b <C-Z>
" Switch to the directory of the current buffer.
map <leader>c :cd %:p:h<cr>
" Tabularize shortcuts
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" Use sudo to overwrite files.
command! Wsudo :execute ':silent w !sudo tee % > /dev/null' | :edit!

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

" Hack for gnome-terminal to use <M-?> bindings
set ttimeout ttimeoutlen=50
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

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
else
  map <M-h> <C-w>h
  map <M-j> <C-w>j
  map <M-k> <C-w>k
  map <M-l> <C-w>l
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
  exe "normal mz"
  %s/\s\+$//e
  exe "normal `z"
endfunction
command! Strip call s:Strip()

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

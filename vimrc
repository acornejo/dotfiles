"***********************************
"General VIM Config
"***********************************
syntax on
filetype plugin indent on
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
set foldmethod=manual       " set manual folding for quick opening of large files
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
set secure                  " disable unsafe commands in per-directory .vimrc

" Use clipboard register.
if has('unnamedplus')
    set clipboard+=unnamedplus
else
    set clipboard+=unnamed
endif

" Storage of various files
set viminfo='1000,\"100,:20,n~/.viminfo " save stuff to ~/.viminfo
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
if has("gui_running")
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
let g:yankring_manage_numbered_reg = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:UltiSnipsListSnippets="<c-q>"
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-q>"
let g:xmledit_enable_html = 1
let g:sparkupExecuteMapping="<c-i>"
let g:airline_powerline_fonts = 0
" let g:airline#extensions#tabline#enabled = 1   " Enable bufline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:syntastic_html_tidy_ignore_errors=['trimming empty', 'lacks "alt" attribute', 'lacks "src" attribute']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {"mode": "passive" }
let g:syntastic_cpp_config_file = '.vim_syntax'
let g:signify_vcs_list = [ 'git' ]
let g:rsi_no_meta = 1

" Use silversearcher instead of grep
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    if &grepformat !~# '%c'
        set grepformat^=%f:%l:%c:%m
    endif
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" remap leader
let mapleader = " "

"************************************
" Autocommands
"************************************
augroup custom-cmds
    " disable syntax highlight on big ruby files
    " autocmd FileType ruby if line2byte(line("$") + 1) > 10000 | syntax clear | endif
    " disable folding in ruby
    autocmd FileType ruby setlocal foldmethod=manual
    " Reload vimrc when modified
    autocmd! BufWritePost .vimrc source ~/.vimrc
    " Go to last position when reopening file
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Change tab stop for html + javascript
    autocmd FileType html,javascript setlocal ts=2 sw=2
    " Disable line wrap for html
    autocmd FileType html setlocal tw=10000
    " Set type of salt sls files to yaml
    autocmd BufNewFile,BufRead *.sls setlocal ft=yaml ts=2 sw=2
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
    " change directory
    autocmd VimEnter * if isdirectory(expand('%:p:h')) | cd %:p:h | endif
    " close unused netrw buffers
    autocmd FileType netrw setl bufhidden=wipe
    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
    " spell check commit messages
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    " Unset paste on InsertLeave
    au InsertLeave * silent! set nopaste
augroup END


"************************************
" Custom mappings
"************************************
" Run make in vmux
nnoremap <leader>m :call VimuxRunCommand("cd " . getcwd() . "; m")<CR>
nnoremap <leader>M :cfile /tmp/make.log<CR>:cw<CR>
" Prompt for vmux command
nnoremap <leader>v :call VimuxPromptCommand()<CR>
" Switch between source and header
nnoremap <leader>s :SwitchSourceHeader<CR>
" close buffer not window
nnoremap <leader>C :bp<bar>bd #<CR>
" Smart identation with braces
inoremap {<CR> {<CR>}<c-o>O
" Switch off highlighting
nnoremap <silent> <backspace> :noh<CR>
" Save a few keystrokes
nnoremap <cr> :

for f in split(glob("~/.vimrc.pre.*"), "\n")
    execute 'source ' . escape(f, '\ "')
endfor
au VimEnter * for f in split(glob("~/.vimrc.post.*"), "\n") | execute 'source ' . escape(f, '\ "') | endfor
